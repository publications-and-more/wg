(*
  WG05: The General Harvard Separation Axiom

  This module formalizes the axiom that execution semantics (G) are
  primitive and cannot be derived from computational behavior theories (O).

  Key insight: Any theory O that models computation requires execution
  to occur, thus implicitly depending on G's primitives. Attempting to
  derive G from O creates circular dependency.

  Author: Amlal El Mahrouss
  Formalization: January 2026
*)

Require Import Stdlib.Logic.Classical_Prop.

(** * Theory Structure *)

(** A theory is characterized by its primitives and derivable statements *)
Record Theory : Type := mkTheory {
  Primitive : Type;
  Statement : Type;
  derives : Primitive -> Statement -> Prop;
  consistent : exists s, forall p, ~ derives p s
}.

Notation "p ⊢ s" := (derives _ p s) (at level 70).

(** * Theory Dependencies *)

(** One theory depends on another if it requires the other's primitives.
    The dependency is witnessed by a mapping from T1's primitives to T2's
    primitives, along with evidence that T2 has primitives (is non-empty). *)
Record DependsOn (T1 T2 : Theory) : Type := mkDependsOn {
  primitive_requirement : Primitive T1 -> Primitive T2;
  target_inhabited : Primitive T2
}.

Arguments primitive_requirement {T1 T2}.
Arguments target_inhabited {T1 T2}.

Notation "T1 ⇒ T2" := (DependsOn T1 T2) (at level 80).

(** Propositional version for use in negations *)
Definition Depends (T1 T2 : Theory) : Prop := inhabited (DependsOn T1 T2).

(** * Execution Semantics Theory (G) *)

(** G formally defines execution semantics: domains, contexts, authority *)
Record ExecutionSemanticsTheory : Type := mkExecutionSemanticsTheory {
  G_theory : Theory;
  has_domains : Primitive G_theory;
  has_contexts : Primitive G_theory;
  has_authority : Primitive G_theory;
  domains_neq_contexts : has_domains <> has_contexts;
  contexts_neq_authority : has_contexts <> has_authority
}.

(** * Computational Behavior Theory (O) *)

(** O is any theory of computational behavior *)
Record ComputationalTheory : Type := mkComputationalTheory {
  O_theory : Theory;
  models_computation : Statement O_theory;
  requires_execution : Prop
}.

(** * The General Harvard Separation Axiom *)

Section HarvardSeparationAxiom.

(** Property 1: If O models computation, then O requires execution to occur *)
Axiom computation_requires_execution :
  forall (O : ComputationalTheory), requires_execution O.

(** Property 2: O implicitly depends on G's primitives
    (execution must be defined for computation to be theorized) *)
Definition implicit_dependency (G : ExecutionSemanticsTheory) (O : ComputationalTheory)
    (H : requires_execution O) : DependsOn (O_theory O) (G_theory G) :=
  {| primitive_requirement := fun _ => has_domains G
   ; target_inhabited := has_domains G
   |}.

(** Property 3: G does not depend on O
    (execution semantics are primitive, not derived from computational models) *)

(** Circular dependency is when A depends on B and B depends on A *)
Definition CircularDependency (T1 T2 : Theory) : Prop :=
  Depends T1 T2 /\ Depends T2 T1.

(** Axiom: Circular dependencies in foundational theories are impossible.
    This captures the intuition that we cannot have A defined in terms of B
    while B is simultaneously defined in terms of A. *)
Axiom no_circular_foundations :
  forall (T1 T2 : Theory), ~ CircularDependency T1 T2.

(** Main Theorem: G cannot be derived from O
    If G were derivable from O, this would create circular dependency *)
Theorem G_not_derivable_from_O :
  forall (G : ExecutionSemanticsTheory) (O : ComputationalTheory),
    DependsOn (G_theory G) (O_theory O) -> False.
Proof.
  intros G O H_G_dep_O.
  apply (no_circular_foundations (G_theory G) (O_theory O)).
  split.
  - exact (inhabits H_G_dep_O).
  - exact (inhabits (implicit_dependency G O (computation_requires_execution O))).
Qed.

(** Corollary: G must be axiomatic.
    G is a foundational primitive that cannot be reduced to
    other computational theories. *)
Record Axiomatic (T : Theory) : Prop := mkAxiomatic {
  not_derivable : forall (O : ComputationalTheory), DependsOn T (O_theory O) -> False
}.

Theorem G_is_axiomatic :
  forall (G : ExecutionSemanticsTheory),
    Axiomatic (G_theory G).
Proof.
  intro G.
  apply mkAxiomatic.
  intros O.
  apply G_not_derivable_from_O.
Qed.

End HarvardSeparationAxiom.

(** * Impossibility of G = O or G ⊆ O *)

Section ImpossibilityResults.

(** Theory equality (both derive from each other) *)
Definition theory_equiv (T1 T2 : Theory) : Prop :=
  Depends T1 T2 /\ Depends T2 T1.

Notation "T1 ≈ T2" := (theory_equiv T1 T2) (at level 70).

(** Theory subsumption (one is contained in the other) *)
Definition theory_subsumes (T1 T2 : Theory) : Prop :=
  Depends T1 T2.

Notation "T1 ⊆ T2" := (theory_subsumes T1 T2) (at level 70).

(** Theorem: G ≠ O (G cannot equal O) *)
Theorem G_not_equiv_O :
  forall (G : ExecutionSemanticsTheory) (O : ComputationalTheory),
    ~ theory_equiv (G_theory G) (O_theory O).
Proof.
  intros G O [[H_G_dep_O] _].
  apply (G_not_derivable_from_O G O).
  exact H_G_dep_O.
Qed.

(** Theorem: G ⊄ O (G cannot be subsumed by O) *)
Theorem G_not_subsumed_by_O :
  forall (G : ExecutionSemanticsTheory) (O : ComputationalTheory),
    ~ theory_subsumes (G_theory G) (O_theory O).
Proof.
  intros G O [H].
  apply (G_not_derivable_from_O G O).
  exact H.
Qed.

End ImpossibilityResults.

(** * Additional Meta-Theoretic Properties *)

Section MetaTheory.

(** The dependency relation is transitive *)
Lemma depends_on_trans :
  forall (T1 T2 T3 : Theory),
    DependsOn T1 T2 -> DependsOn T2 T3 -> DependsOn T1 T3.
Proof.
  intros T1 T2 T3 H12 H23.
  exact {| primitive_requirement := fun p => primitive_requirement H23 (primitive_requirement H12 p)
         ; target_inhabited := target_inhabited H23
         |}.
Qed.

(** If G is axiomatic and O depends on G, then O cannot be axiomatic
    with respect to theories that G depends on *)
Lemma axiomatic_asymmetry :
  forall (G : ExecutionSemanticsTheory) (O : ComputationalTheory),
    DependsOn (O_theory O) (G_theory G) ->
    Axiomatic (G_theory G) ->
    DependsOn (G_theory G) (O_theory O) -> False.
Proof.
  intros G O H_O_dep_G H_G_ax.
  apply (not_derivable _ H_G_ax).
Qed.

End MetaTheory.
