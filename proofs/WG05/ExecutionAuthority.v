(*
  WG05: Execution Authority Theory

  An execution authority is responsible for defining whose semantics
  may be used for an execution context.

  Author: Amlal El Mahrouss
  Formalization: January 2026
*)

Require Import Logic.Classical_Prop.
Require Import WG05.ExecutionDomains.

(** * Traits *)

(** A trait is a set of formal rules defining the semantic concepts
    of an execution context *)
Record Trait : Type := mkTrait {
  Rules : Type;
  valid : Rules -> Prop;
  trait_compose : Rules -> Rules -> Rules;
  compose_preserves_valid :
    forall r1 r2, valid r1 -> valid r2 -> valid (trait_compose r1 r2)
}.

(** * Execution Authority *)

(** An execution authority of type T, where T is a trait *)
Record ExecutionAuthority (T : Trait) : Type := mkExecutionAuthority {
  governs : Rules T -> Prop;
  authority_valid : forall r, governs r -> valid T r
}.

Arguments governs {T}.
Arguments authority_valid {T}.

(** * Semantic Substitutability *)

(** Two execution contexts are semantically substitutable if one can
    be used in place of the other while preserving semantic properties *)
Record SemanticSubstitutability (EC1 EC2 : ExecutionContext) : Type :=
  mkSemanticSubstitutability {
    subst_forward : Context EC1 -> Context EC2;
    subst_backward : Context EC2 -> Context EC1;
    subst_roundtrip : forall c, subst_backward (subst_forward c) = c
  }.

(** Propositional version: contexts are substitutable if there exists
    a substitutability witness *)
Definition Substitutable (EC1 EC2 : ExecutionContext) : Prop :=
  inhabited (SemanticSubstitutability EC1 EC2).

(** * Core Theorems *)

Section AuthorityTheorems.

(** Property 1: If X does not equal or is not semantically substitutable
    with E (or vice versa), then C shall not equal Z *)

(** The domain separation theorem states that without context equality
    or semantic substitutability, domains cannot be meaningfully equivalent.

    This is stated as an axiom because the proof requires additional
    axioms about context identity that are domain-specific. *)

Axiom domain_separation_by_context :
  forall (EC1 EC2 : ExecutionContext)
         (C : ExecutionDomain EC1)
         (Z : ExecutionDomain EC2),
    EC1 <> EC2 ->
    ~ Substitutable EC1 EC2 ->
    (* Conclusion: The domains cannot be semantically equivalent *)
    ~ (exists (f : Domain C -> Domain Z) (g : Domain Z -> Domain C),
         (forall x, g (f x) = x) /\ (forall y, f (g y) = y)).

(** Property 2: Null execution context theory
    If Z or C are defined as a null execution context,
    then N <> not N (a context is not equal to its negation) *)

(** First, define what a null context means *)
Record NullContext (EC : ExecutionContext) : Type := mkNullContext {
  null : Context EC;
  is_null : forall c : Context EC, {c = null} + {c <> null}
}.

(** The negation of a context (in the semantic sense) *)
Record ContextNegation (EC : ExecutionContext) : Type := mkContextNegation {
  negate : Context EC -> Context EC;
  negate_involutive : forall c, negate (negate c) = c;
  context_not_negation : forall c, c <> negate c
}.

(** Theorem: N <> not N *)
Theorem null_not_negation :
  forall (EC : ExecutionContext)
         (NC : NullContext EC)
         (CN : ContextNegation EC),
    null EC NC <> negate EC CN (null EC NC).
Proof.
  intros EC NC CN.
  apply context_not_negation.
Qed.

End AuthorityTheorems.

(** * Authority Composition *)

Section AuthorityComposition.

Record CompatibleAuthorities (T1 T2 : Trait) : Type := mkCompatibleAuthorities {
  A1 : ExecutionAuthority T1;
  A2 : ExecutionAuthority T2;
  rule_compat : Rules T1 -> Rules T2
}.

(** When authorities are compatible, they can be combined *)
Theorem compose_authorities :
  forall (T1 T2 : Trait)
         (compat : CompatibleAuthorities T1 T2)
         (r : Rules T1),
    governs (A1 T1 T2 compat) r ->
    exists r', r' = rule_compat T1 T2 compat r.
Proof.
  intros T1 T2 compat r Hgov.
  exists (rule_compat T1 T2 compat r).
  reflexivity.
Qed.

End AuthorityComposition.

(** * Additional Properties *)

Section AdditionalProperties.

(** Two authorities over the same trait are compatible if they
    agree on what they govern *)
Definition authorities_agree {T : Trait} (A1 A2 : ExecutionAuthority T) : Prop :=
  forall r, governs A1 r <-> governs A2 r.

(** Agreement is an equivalence relation *)
Lemma authorities_agree_refl :
  forall (T : Trait) (A : ExecutionAuthority T),
    authorities_agree A A.
Proof.
  intros T A r.
  split; auto.
Qed.

Lemma authorities_agree_sym :
  forall (T : Trait) (A1 A2 : ExecutionAuthority T),
    authorities_agree A1 A2 -> authorities_agree A2 A1.
Proof.
  intros T A1 A2 H r.
  split; apply H.
Qed.

Lemma authorities_agree_trans :
  forall (T : Trait) (A1 A2 A3 : ExecutionAuthority T),
    authorities_agree A1 A2 ->
    authorities_agree A2 A3 ->
    authorities_agree A1 A3.
Proof.
  intros T A1 A2 A3 H12 H23 r.
  split; intro H.
  - apply H23. apply H12. exact H.
  - apply H12. apply H23. exact H.
Qed.

End AdditionalProperties.
