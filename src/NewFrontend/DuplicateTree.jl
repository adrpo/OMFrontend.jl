module DuplicateTree
using MetaModelica
using ExportAll
#= Forward declarations for uniontypes until Julia adds support for mutual recursion =#
using ..BaseAvlTree #= Modelica extend clause =#

@UniontypeDecl Entry
Key = String
Value = Entry

#= Modelica extend clause =#
include("../Util/baseAvlTreeCode.jl")
include("../Util/baseAvlSetCode.jl")

import ..LookupTree
import ..InstNode
EntryType = (() -> begin #= Enumeration =#
  DUPLICATE = 1
  REDECLARE = 2
  ENTRY = 3
  () -> (DUPLICATE; REDECLARE; ENTRY)
end)()
EntryTypeTy = Integer

@Uniontype Entry begin
  @Record DUPLICATE_TREE_ENTRY begin
    entry::LookupTree.Entry
    node::Option{InstNode}
    children::List{Entry}
    ty::EntryTypeTy
  end
end

function new()
  return EMPTY();
end

function newRedeclare(entry::LookupTree.Entry) :Entry
  local redecl::Entry = DUPLICATE_TREE_ENTRY(entry, NONE(), nil, EntryType.REDECLARE)
  return redecl
end

function newDuplicate(kept::LookupTree.Entry, duplicate::LookupTree.Entry)::Entry
  local entry::Entry = DUPLICATE_TREE_ENTRY(kept, NONE(), list(newEntry(duplicate)), EntryType.DUPLICATE)
  return entry
end

function newEntry(lentry::LookupTree.Entry)::Entry
  local entry::Entry = DUPLICATE_TREE_ENTRY(lentry, NONE(), nil, EntryType.ENTRY)
  return entry
end

function idExistsInEntry(id::LookupTree.Entry, entry::Entry)::Bool
  local exists::Bool
  @assign exists =
    LookupTree.isEqual(id, entry.entry) ||
    ListUtil.exist(entry.children, (id) -> idExistsInEntry(id = id))
  return exists
end

@exportAll()
end