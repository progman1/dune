open Stdune

include module type of Dune_memory_intf

type 'a result = ('a, string) Result.t

val default_root : unit -> Path.t

module Key : sig
  type t = Digest.t

  val of_string : string -> (t, string) Result.t

  val to_string : t -> string
end

val promotion_to_string : promotion -> string

val command_to_dyn : command -> Dyn.t

module Memory : sig
  include Memory

  val promote_sync :
       t
    -> (Path.Build.t * Digest.t) list
    -> Key.t
    -> metadata
    -> int option
    -> (promotion list, string) Result.t

  val make : ?root:Path.t -> handler -> (t, string) Result.t
end

(** The size overhead of cached files. That is, the total size of cached files
    that are not linked in a build directory. *)
val size : Memory.t -> int

(** [trim memory size] removes files from [memory], starting with the least
    recently used one, until [size] bytes have been freed. *)
val trim : Memory.t -> int -> trimming_result

(** Purge invalid or incomplete cached rules. *)
val garbage_collect : Memory.t -> trimming_result

val make_caching : (module Memory with type t = 'a) -> 'a -> (module Caching)
