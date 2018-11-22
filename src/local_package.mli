(** Represents an in source package definition along with all of its associated
    stanzas required for installing *)

open Stdune

type t

val build_dir : t -> Path.t

val lib_stanzas : t -> Dune_file.Library.t Dir_with_dune.t list

val mlds : t -> Path.t list

val installs
  : t
  -> string Dune_file.Install_conf.t Dir_with_dune.t list

val odig_files : t -> Path.t list

val of_sctx : Super_context.t -> t Package.Name.Map.t

val meta_file : t -> Path.t

val opam_file : t -> Path.t

val name : t -> Package.Name.t

val install_paths : t -> Install.Section.Paths.t

val libs : t -> Lib.Set.t

val package : t -> Package.t
