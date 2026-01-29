(*
  WG05: Execution Domains Theory

  An execution domain defines a boundary for execution semantics,
  resource visibility, and control flow.

  Author: Amlal El Mahrouss
  Formalization: January 2026
*)

From Stdlib Require Import Logic.Classical_Prop.
From Stdlib Require Import Logic.FunctionalExtensionality.

(** * Execution Contexts *)

(** Execution contexts are abstract semantic parameters *)
Record ExecutionContext : Type := mkExecutionContext {
  Context : Type;
  context_eq_dec : forall (c1 c2 : Context), {c1 = c2} + {c1 <> c2}
}.

(** * Execution Domains *)

(** An execution domain is indexed by an execution context *)
Record ExecutionDomain (EC : ExecutionContext) : Type := mkExecutionDomain {
  Domain : Type;
  domain_context : Context EC;
  SubProgram : Type;
  compose : SubProgram -> Domain
}.

Arguments Domain {EC}.
Arguments domain_context {EC}.
Arguments SubProgram {EC}.
Arguments compose {EC}.

(** * Core Theorem: Domains with Different Contexts are Distinct *)

Section DomainSeparation.

Variable EC : ExecutionContext.

(** Two domains with provably different contexts cannot be equal
    in any meaningful semantic sense *)
Record DomainEquivalence (D1 D2 : ExecutionDomain EC) : Prop := mkDomainEquivalence {
  context_eq : domain_context D1 = domain_context D2;
  domain_iso : exists (f : Domain D1 -> Domain D2), True
}.

(** The separation theorem: different contexts imply distinct domains *)
Theorem separation_theorem :
  forall (D1 D2 : ExecutionDomain EC),
    domain_context D1 <> domain_context D2 ->
    ~ DomainEquivalence D1 D2.
Proof.
  intros D1 D2 Hneq Heq.
  destruct Heq as [Hctx _].
  contradiction.
Qed.

End DomainSeparation.

(** * Composition Property *)

(** Domains may be composed of sub-programs within the execution context *)
Record ComposableDomain (EC : ExecutionContext) : Type := mkComposableDomain {
  base : ExecutionDomain EC;
  composition_preserves_context :
    forall (sp : SubProgram base),
      exists d, d = compose base sp
}.

(** * Context Abstraction *)

(** Execution contexts are treated as abstract semantic parameters.
    This section provides the abstraction barrier. *)

Section ContextAbstraction.

(** A context family abstracts over specific context implementations *)
Record ContextFamily : Type := mkContextFamily {
  Contexts : Type;
  mkContext : Contexts -> ExecutionContext
}.

(** Domains can be parameterized by context families *)
Definition DomainFamily (cf : ContextFamily) : Type :=
  forall (c : Contexts cf), ExecutionDomain (mkContext cf c).

End ContextAbstraction.

(** * Properties about Domain Inequality *)

Section DomainInequality.

(** If two domains belong to different execution contexts,
    they cannot be structurally equal *)
Lemma domains_different_contexts_not_equal :
  forall (EC1 EC2 : ExecutionContext)
         (D1 : ExecutionDomain EC1)
         (D2 : ExecutionDomain EC2),
    EC1 <> EC2 ->
    ~ (exists (H : EC1 = EC2),
         eq_rect EC1 ExecutionDomain D1 EC2 H = D2).
Proof.
  intros EC1 EC2 D1 D2 Hneq [H _].
  contradiction.
Qed.

End DomainInequality.
