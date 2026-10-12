# OOP Lab — Answers

**Name:** Muhammad Hussain AbdulRehman
**Roll Number:** 04072313047

---

## Q1. What can a subclass using `extends` use for free that a class using `implements` has to write itself?

A subclass using `extends` inherits the parent's fields and fully implemented
methods for free, and can call them with `super`. A class using `implements`
only gets the signatures (the contract) — it must write every field, getter,
and method body itself because the parent's implementation is not inherited.

---

## Q2. Book and Dvd both use Renewable. When would you pick a mixin, and when an abstract parent class?

Pick a mixin when two unrelated classes need to share the same reusable
behavior without becoming related by inheritance (Book and Dvd are not
kinds of each other). Pick an abstract parent class when the classes are
truly an "is-a" family and should share state plus have common abstract
methods that the parent declares and the children implement.

---

## Q3. Why must you override hashCode whenever you override ==?

Because Dart's hash-based collections (Set, Map) use hashCode to decide
which bucket an object goes into, and then use == to check equality inside
that bucket. If two objects are equal by == but have different hashCodes,
they land in different buckets and the Set/Map treats them as separate
entries — breaking the collection's contract.

---

## Q4. An extension method on String and a subclass of String both add behaviour. Why does Dart let you write the first one but not the second?

Dart does not allow extending built-in types like String with `extends`
because their internal representation is fixed and subclassing would break
core assumptions of the language and VM. Extension methods are resolved
statically at compile time and only add new methods to the existing type's
interface, so they add behaviour without changing String's runtime layout
or identity.
