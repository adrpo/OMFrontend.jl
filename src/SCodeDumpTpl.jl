module SCodeDumpTpl

using MetaModelica
using ExportAll

import Main.Tpl

import Absyn

import Main.Dump

import Main.SCode

import Main.SCodeDump

import Main.Config

import Main.System

import Main.Util

import Main.Error

import Main.AbsynDumpTpl

function dumpProgram(
  txt::Tpl.Text,
  a_program::List{<:SCode.Element},
  a_options::SCodeDump.SCodeDumpOptions,
)::Tpl.Text
  local out_txt::Tpl.Text

  @assign out_txt = dumpElements(txt, a_program, false, a_options)
  return out_txt
end

function dumpElements(
  txt::Tpl.Text,
  a_elements::List{<:SCode.Element},
  a_indent::Bool,
  a_options::SCodeDump.SCodeDumpOptions,
)::Tpl.Text
  local out_txt::Tpl.Text

  local ret_0::List{SCode.Element}

  @assign ret_0 = SCodeDump.filterElements(a_elements, a_options)
  @assign out_txt = dumpElements2(txt, ret_0, a_indent, a_options)
  return out_txt
end

function dumpElements2(
  txt::Tpl.Text,
  a_elements::List{<:SCode.Element},
  a_indent::Bool,
  a_options::SCodeDump.SCodeDumpOptions,
)::Tpl.Text
  local out_txt::Tpl.Text

  local ret_2::Util.StatefulBoolean
  local ret_1::Util.StatefulBoolean
  local ret_0::Integer

  @assign ret_0 = listLength(a_elements)
  @assign ret_1 = Util.makeStatefulBoolean(false)
  @assign ret_2 = Util.makeStatefulBoolean(true)
  @assign out_txt = dumpElements3(txt, a_elements, ret_0, ret_1, a_indent, ret_2, a_options)
  return out_txt
end

function fun_14(
  in_txt::Tpl.Text,
  in_mArg::Bool,
  in_a_prevSpacing::Array{<:Bool},
  in_a_spacing::Tpl.Text,
)::Tpl.Text
  local out_txt::Tpl.Text

  @assign out_txt = begin
    local txt::Tpl.Text
    local a_prevSpacing::Array{Bool}
    local a_spacing::Tpl.Text
    local ret_0::Bool
    @match (in_txt, in_mArg, in_a_prevSpacing, in_a_spacing) begin
      (txt, false, _, _) => begin
        txt
      end

      (txt, _, a_prevSpacing, a_spacing) => begin
        @assign ret_0 = Util.getStatefulBoolean(a_prevSpacing)
        @assign txt = dumpPreElementSpacing(txt, Tpl.textString(a_spacing), ret_0)
        txt
      end
    end
  end
  return out_txt
end

function fun_15(
  in_txt::Tpl.Text,
  in_a_vis__str::Tpl.Text,
  in_a_inPublicSection::Array{<:Bool},
)::Tpl.Text
  local out_txt::Tpl.Text

  @assign out_txt = begin
    local txt::Tpl.Text
    local a_inPublicSection::Array{Bool}
    local ret_1::Bool
    local ret_0::Bool
    @match (in_txt, in_a_vis__str, in_a_inPublicSection) begin
      (txt, Tpl.MEM_TEXT(tokens = nil()), _) => begin
        txt
      end

      (txt, _, a_inPublicSection) => begin
        @assign ret_0 = Util.getStatefulBoolean(a_inPublicSection)
        @assign ret_1 = boolNot(ret_0)
        Util.setStatefulBoolean(a_inPublicSection, ret_1)
        txt
      end
    end
  end
  return out_txt
end

function fun_16(
  in_txt::Tpl.Text,
  in_a_spacing::Tpl.Text,
  in_a_prevSpacing::Array{<:Bool},
)::Tpl.Text
  local out_txt::Tpl.Text

  @assign out_txt = begin
    local txt::Tpl.Text
    local a_prevSpacing::Array{Bool}
    local i_spacing::Tpl.Text
    @match (in_txt, in_a_spacing, in_a_prevSpacing) begin
      (txt, Tpl.MEM_TEXT(tokens = nil()), a_prevSpacing) => begin
        Util.setStatefulBoolean(a_prevSpacing, false)
        txt
      end

      (txt, i_spacing, a_prevSpacing) => begin
        Util.setStatefulBoolean(a_prevSpacing, true)
        @assign txt = Tpl.writeText(txt, i_spacing)
        txt
      end
    end
  end
  return out_txt
end

function fun_17(
  in_txt::Tpl.Text,
  in_mArg::Bool,
  in_a_spacing::Tpl.Text,
  in_a_prevSpacing::Array{<:Bool},
)::Tpl.Text
  local out_txt::Tpl.Text

  @assign out_txt = begin
    local txt::Tpl.Text
    local a_spacing::Tpl.Text
    local a_prevSpacing::Array{Bool}
    @match (in_txt, in_mArg, in_a_spacing, in_a_prevSpacing) begin
      (txt, false, _, a_prevSpacing) => begin
        Util.setStatefulBoolean(a_prevSpacing, false)
        txt
      end

      (txt, _, a_spacing, a_prevSpacing) => begin
        @assign txt = fun_16(txt, a_spacing, a_prevSpacing)
        txt
      end
    end
  end
  return out_txt
end

function fun_18(
  in_txt::Tpl.Text,
  in_a_indent::Bool,
  in_a_post__spacing::Tpl.Text,
  in_a_el__str::Tpl.Text,
  in_a_vis__str::Tpl.Text,
  in_a_pre__spacing::Tpl.Text,
)::Tpl.Text
  local out_txt::Tpl.Text

  @assign out_txt = begin
    local txt::Tpl.Text
    local a_post__spacing::Tpl.Text
    local a_el__str::Tpl.Text
    local a_vis__str::Tpl.Text
    local a_pre__spacing::Tpl.Text
    @match (
      in_txt,
      in_a_indent,
      in_a_post__spacing,
      in_a_el__str,
      in_a_vis__str,
      in_a_pre__spacing,
    ) begin
      (txt, false, a_post__spacing, a_el__str, a_vis__str, a_pre__spacing) => begin
        @assign txt = Tpl.writeText(txt, a_pre__spacing)
        @assign txt = Tpl.writeText(txt, a_vis__str)
        @assign txt = Tpl.softNewLine(txt)
        @assign txt = Tpl.writeText(txt, a_el__str)
        @assign txt = Tpl.writeTok(txt, Tpl.ST_STRING(";"))
        @assign txt = Tpl.writeText(txt, a_post__spacing)
        @assign txt = Tpl.writeTok(txt, Tpl.ST_NEW_LINE())
        txt
      end

      (txt, _, a_post__spacing, a_el__str, a_vis__str, a_pre__spacing) => begin
        @assign txt = Tpl.writeText(txt, a_pre__spacing)
        @assign txt = Tpl.writeText(txt, a_vis__str)
        @assign txt = Tpl.softNewLine(txt)
        @assign txt = Tpl.pushBlock(txt, Tpl.BT_INDENT(2))
        @assign txt = Tpl.writeText(txt, a_el__str)
        @assign txt = Tpl.writeTok(txt, Tpl.ST_STRING(";"))
        @assign txt = Tpl.writeText(txt, a_post__spacing)
        @assign txt = Tpl.writeTok(txt, Tpl.ST_NEW_LINE())
        @assign txt = Tpl.popBlock(txt)
        txt
      end
    end
  end
  return out_txt
end

function lm_19(
  in_txt::Tpl.Text,
  in_items::List{<:SCode.Element},
  in_a_indent::Bool,
  in_a_numElements::Integer,
  in_a_inPublicSection::Array{<:Bool},
  in_a_options::SCodeDump.SCodeDumpOptions,
  in_a_prevSpacing::Array{<:Bool},
)::Tpl.Text
  local out_txt::Tpl.Text

  @assign out_txt = begin
    local txt::Tpl.Text
    local rest::List{SCode.Element}
    local a_indent::Bool
    local a_numElements::Integer
    local a_inPublicSection::Array{Bool}
    local a_options::SCodeDump.SCodeDumpOptions
    local a_prevSpacing::Array{Bool}
    local x_i1::Integer
    local i_el::SCode.Element
    local ret_10::Bool
    local ret_9::Bool
    local l_post__spacing::Tpl.Text
    local l_dummyTxt::Tpl.Text
    local ret_6::Bool
    local l_vis__str::Tpl.Text
    local l_el__str::Tpl.Text
    local ret_3::Bool
    local ret_2::Bool
    local l_pre__spacing::Tpl.Text
    local l_spacing::Tpl.Text
    @match (
      in_txt,
      in_items,
      in_a_indent,
      in_a_numElements,
      in_a_inPublicSection,
      in_a_options,
      in_a_prevSpacing,
    ) begin
      (txt, nil(), _, _, _, _, _) => begin
        txt
      end

      (
        txt,
        i_el <| rest,
        a_indent,
        a_numElements,
        a_inPublicSection,
        a_options,
        a_prevSpacing,
      ) => begin
        @assign x_i1 = Tpl.getIteri_i0(txt)
        @assign l_spacing = dumpElementSpacing(Tpl.emptyTxt, i_el)
        @assign ret_2 = intEq(1, x_i1)
        @assign ret_3 = boolNot(ret_2)
        @assign l_pre__spacing = fun_14(Tpl.emptyTxt, ret_3, a_prevSpacing, l_spacing)
        @assign l_el__str = dumpElement(Tpl.emptyTxt, i_el, "", a_options)
        @assign ret_6 = Util.getStatefulBoolean(a_inPublicSection)
        @assign l_vis__str = dumpElementVisibility(Tpl.emptyTxt, i_el, ret_6)
        @assign l_dummyTxt = fun_15(Tpl.emptyTxt, l_vis__str, a_inPublicSection)
        @assign ret_9 = intEq(x_i1, a_numElements)
        @assign ret_10 = boolNot(ret_9)
        @assign l_post__spacing = fun_17(Tpl.emptyTxt, ret_10, l_spacing, a_prevSpacing)
        @assign txt =
          fun_18(txt, a_indent, l_post__spacing, l_el__str, l_vis__str, l_pre__spacing)
        @assign txt = Tpl.nextIter(txt)
        @assign txt = lm_19(
          txt,
          rest,
          a_indent,
          a_numElements,
          a_inPublicSection,
          a_options,
          a_prevSpacing,
        )
        txt
      end
    end
  end
  return out_txt
end

function dumpElements3(
  txt::Tpl.Text,
  a_elements::List{<:SCode.Element},
  a_numElements::Integer,
  a_prevSpacing::Array{<:Bool},
  a_indent::Bool,
  a_inPublicSection::Array{<:Bool},
  a_options::SCodeDump.SCodeDumpOptions,
)::Tpl.Text
  local out_txt::Tpl.Text

  @assign out_txt = Tpl.pushIter(
    txt,
    Tpl.ITER_OPTIONS(1, NONE(), NONE(), 0, 0, Tpl.ST_NEW_LINE(), 0, Tpl.ST_NEW_LINE()),
  )
  @assign out_txt = lm_19(
    out_txt,
    a_elements,
    a_indent,
    a_numElements,
    a_inPublicSection,
    a_options,
    a_prevSpacing,
  )
  @assign out_txt = Tpl.popIter(out_txt)
  return out_txt
end

function fun_21(in_txt::Tpl.Text, in_a_prevSpacing::Bool, in_a_curSpacing::String)::Tpl.Text
  local out_txt::Tpl.Text

  @assign out_txt = begin
    local txt::Tpl.Text
    local a_curSpacing::String
    @match (in_txt, in_a_prevSpacing, in_a_curSpacing) begin
      (txt, false, a_curSpacing) => begin
        @assign txt = Tpl.writeStr(txt, a_curSpacing)
        txt
      end

      (txt, _, _) => begin
        txt
      end
    end
  end
  return out_txt
end

function dumpPreElementSpacing(
  txt::Tpl.Text,
  a_curSpacing::String,
  a_prevSpacing::Bool,
)::Tpl.Text
  local out_txt::Tpl.Text

  @assign out_txt = fun_21(txt, a_prevSpacing, a_curSpacing)
  return out_txt
end

function dumpElementSpacing(in_txt::Tpl.Text, in_a_element::SCode.Element)::Tpl.Text
  local out_txt::Tpl.Text

  @assign out_txt = begin
    local txt::Tpl.Text
    local i_classDef::SCode.ClassDef
    @match (in_txt, in_a_element) begin
      (txt, SCode.CLASS(classDef = i_classDef)) => begin
        @assign txt = dumpClassDefSpacing(txt, i_classDef)
        txt
      end

      (txt, _) => begin
        txt
      end
    end
  end
  return out_txt
end

function dumpClassDefSpacing(in_txt::Tpl.Text, in_a_classDef::SCode.ClassDef)::Tpl.Text
  local out_txt::Tpl.Text

  @assign out_txt = begin
    local txt::Tpl.Text
    local i_composition::SCode.ClassDef
    @match (in_txt, in_a_classDef) begin
      (txt, SCode.CLASS_EXTENDS(composition = i_composition)) => begin
        @assign txt = dumpClassDefSpacing(txt, i_composition)
        txt
      end

      (txt, SCode.PARTS(elementLst = _)) => begin
        @assign txt = Tpl.writeTok(txt, Tpl.ST_NEW_LINE())
        txt
      end

      (txt, _) => begin
        txt
      end
    end
  end
  return out_txt
end

function fun_25(
  in_txt::Tpl.Text,
  in_a_options::SCodeDump.SCodeDumpOptions,
  in_a_element::SCode.Element,
)::Tpl.Text
  local out_txt::Tpl.Text

  @assign out_txt = begin
    local txt::Tpl.Text
    local a_element::SCode.Element
    @match (in_txt, in_a_options, in_a_element) begin
      (txt, SCodeDump.OPTIONS(stripProtectedImports = true), _) => begin
        txt
      end

      (txt, _, a_element) => begin
        @assign txt = dumpImport(txt, a_element)
        txt
      end
    end
  end
  return out_txt
end

function fun_26(
  in_txt::Tpl.Text,
  in_a_visibility::SCode.Visibility,
  in_a_element::SCode.Element,
  in_a_options::SCodeDump.SCodeDumpOptions,
)::Tpl.Text
  local out_txt::Tpl.Text

  @assign out_txt = begin
    local txt::Tpl.Text
    local a_element::SCode.Element
    local a_options::SCodeDump.SCodeDumpOptions
    @match (in_txt, in_a_visibility, in_a_element, in_a_options) begin
      (txt, SCode.PROTECTED(__), a_element, a_options) => begin
        @assign txt = fun_25(txt, a_options, a_element)
        txt
      end

      (txt, _, a_element, _) => begin
        @assign txt = dumpImport(txt, a_element)
        txt
      end
    end
  end
  return out_txt
end

function dumpElement(
  in_txt::Tpl.Text,
  in_a_element::SCode.Element,
  in_a_each::String,
  in_a_options::SCodeDump.SCodeDumpOptions,
)::Tpl.Text
  local out_txt::Tpl.Text

  @assign out_txt = begin
    local txt::Tpl.Text
    local a_each::String
    local a_options::SCodeDump.SCodeDumpOptions
    local i_element::SCode.Element
    local i_visibility::SCode.Visibility
    @match (in_txt, in_a_element, in_a_each, in_a_options) begin
      (txt, i_element && SCode.IMPORT(visibility = i_visibility), _, a_options) => begin
        @assign txt = fun_26(txt, i_visibility, i_element, a_options)
        txt
      end

      (txt, i_element && SCode.EXTENDS(baseClassPath = _), _, a_options) => begin
        @assign txt = dumpExtends(txt, i_element, a_options)
        txt
      end

      (txt, i_element && SCode.CLASS(name = _), a_each, a_options) => begin
        @assign txt = dumpClass(txt, i_element, a_each, a_options)
        txt
      end

      (txt, i_element && SCode.COMPONENT(name = _), a_each, a_options) => begin
        @assign txt = dumpComponent(txt, i_element, a_each, a_options)
        txt
      end

      (txt, i_element && SCode.DEFINEUNIT(name = _), _, _) => begin
        @assign txt = dumpDefineUnit(txt, i_element)
        txt
      end

      (txt, _, _, _) => begin
        @assign txt = errorMsg(txt, "SCodeDump.dumpElement: Unknown element.")
        txt
      end
    end
  end
  return out_txt
end

function dumpElementVisibility(
  in_txt::Tpl.Text,
  in_a_element::SCode.Element,
  in_a_inPublicSection::Bool,
)::Tpl.Text
  local out_txt::Tpl.Text

  @assign out_txt = begin
    local txt::Tpl.Text
    local a_inPublicSection::Bool
    local i_vis::SCode.Visibility
    local i_visibility::SCode.Visibility
    @match (in_txt, in_a_element, in_a_inPublicSection) begin
      (txt, SCode.IMPORT(visibility = i_visibility), a_inPublicSection) => begin
        @assign txt = dumpSectionVisibility(txt, i_visibility, a_inPublicSection)
        txt
      end

      (txt, SCode.EXTENDS(visibility = i_visibility), a_inPublicSection) => begin
        @assign txt = dumpSectionVisibility(txt, i_visibility, a_inPublicSection)
        txt
      end

      (
        txt,
        SCode.CLASS(prefixes = SCode.PREFIXES(visibility = i_vis)),
        a_inPublicSection,
      ) => begin
        @assign txt = dumpSectionVisibility(txt, i_vis, a_inPublicSection)
        txt
      end

      (
        txt,
        SCode.COMPONENT(prefixes = SCode.PREFIXES(visibility = i_vis)),
        a_inPublicSection,
      ) => begin
        @assign txt = dumpSectionVisibility(txt, i_vis, a_inPublicSection)
        txt
      end

      (txt, SCode.DEFINEUNIT(visibility = i_visibility), a_inPublicSection) => begin
        @assign txt = dumpSectionVisibility(txt, i_visibility, a_inPublicSection)
        txt
      end

      (txt, _, _) => begin
        txt
      end
    end
  end
  return out_txt
end

function fun_29(in_txt::Tpl.Text, in_a_inPublicSection::Bool)::Tpl.Text
  local out_txt::Tpl.Text

  @assign out_txt = begin
    local txt::Tpl.Text
    @match (in_txt, in_a_inPublicSection) begin
      (txt, false) => begin
        @assign txt = Tpl.writeTok(txt, Tpl.ST_STRING("public"))
        @assign txt = Tpl.writeTok(txt, Tpl.ST_NEW_LINE())
        txt
      end

      (txt, _) => begin
        txt
      end
    end
  end
  return out_txt
end

function fun_30(in_txt::Tpl.Text, in_a_inPublicSection::Bool)::Tpl.Text
  local out_txt::Tpl.Text

  @assign out_txt = begin
    local txt::Tpl.Text
    @match (in_txt, in_a_inPublicSection) begin
      (txt, false) => begin
        txt
      end

      (txt, _) => begin
        @assign txt = Tpl.writeTok(txt, Tpl.ST_STRING("protected"))
        @assign txt = Tpl.writeTok(txt, Tpl.ST_NEW_LINE())
        txt
      end
    end
  end
  return out_txt
end

function dumpSectionVisibility(
  in_txt::Tpl.Text,
  in_a_visibility::SCode.Visibility,
  in_a_inPublicSection::Bool,
)::Tpl.Text
  local out_txt::Tpl.Text

  @assign out_txt = begin
    local txt::Tpl.Text
    local a_inPublicSection::Bool
    @match (in_txt, in_a_visibility, in_a_inPublicSection) begin
      (txt, SCode.PUBLIC(__), a_inPublicSection) => begin
        @assign txt = fun_29(txt, a_inPublicSection)
        txt
      end

      (txt, SCode.PROTECTED(__), a_inPublicSection) => begin
        @assign txt = fun_30(txt, a_inPublicSection)
        txt
      end

      (txt, _, _) => begin
        txt
      end
    end
  end
  return out_txt
end

function fun_32(in_txt::Tpl.Text, in_a_imp::Absyn.Import)::Tpl.Text
  local out_txt::Tpl.Text

  @assign out_txt = begin
    local txt::Tpl.Text
    local i_path::Absyn.Path
    local i_name::Absyn.Ident
    @match (in_txt, in_a_imp) begin
      (txt, Absyn.NAMED_IMPORT(name = i_name, path = i_path)) => begin
        @assign txt = Tpl.writeTok(txt, Tpl.ST_STRING("import "))
        @assign txt = Tpl.writeStr(txt, i_name)
        @assign txt = Tpl.writeTok(txt, Tpl.ST_STRING(" = "))
        @assign txt = AbsynDumpTpl.dumpPath(txt, i_path)
        txt
      end

      (txt, Absyn.QUAL_IMPORT(path = i_path)) => begin
        @assign txt = Tpl.writeTok(txt, Tpl.ST_STRING("import "))
        @assign txt = AbsynDumpTpl.dumpPath(txt, i_path)
        txt
      end

      (txt, Absyn.UNQUAL_IMPORT(path = i_path)) => begin
        @assign txt = Tpl.writeTok(txt, Tpl.ST_STRING("import "))
        @assign txt = AbsynDumpTpl.dumpPath(txt, i_path)
        @assign txt = Tpl.writeTok(txt, Tpl.ST_STRING(".*"))
        txt
      end

      (txt, _) => begin
        @assign txt = errorMsg(txt, "SCodeDump.dumpImport: Unknown import.")
        txt
      end
    end
  end
  return out_txt
end

function dumpImport(in_txt::Tpl.Text, in_a_import::SCode.Element)::Tpl.Text
  local out_txt::Tpl.Text

  @assign out_txt = begin
    local txt::Tpl.Text
    local i_imp::Absyn.Import
    local i_visibility::SCode.Visibility
    local l_import__str::Tpl.Text
    local l_visibility__str::Tpl.Text
    @match (in_txt, in_a_import) begin
      (txt, SCode.IMPORT(visibility = i_visibility, imp = i_imp)) => begin
        @assign l_visibility__str = dumpVisibility(Tpl.emptyTxt, i_visibility)
        @assign l_import__str = fun_32(Tpl.emptyTxt, i_imp)
        @assign txt = Tpl.writeText(txt, l_visibility__str)
        @assign txt = Tpl.writeText(txt, l_import__str)
        txt
      end

      (txt, _) => begin
        txt
      end
    end
  end
  return out_txt
end

function dumpExtends(
  in_txt::Tpl.Text,
  in_a_extends::SCode.Element,
  in_a_options::SCodeDump.SCodeDumpOptions,
)::Tpl.Text
  local out_txt::Tpl.Text

  @assign out_txt = begin
    local txt::Tpl.Text
    local a_options::SCodeDump.SCodeDumpOptions
    local i_ann::Option{SCode.Annotation}
    local i_modifications::SCode.Mod
    local i_visibility::SCode.Visibility
    local i_baseClassPath::SCode.Path
    local l_ann__str::Tpl.Text
    local l_mod__str::Tpl.Text
    local l_visibility__str::Tpl.Text
    local l_bc__str::Tpl.Text
    @match (in_txt, in_a_extends, in_a_options) begin
      (
        txt,
        SCode.EXTENDS(
          baseClassPath = i_baseClassPath,
          visibility = i_visibility,
          modifications = i_modifications,
          ann = i_ann,
        ),
        a_options,
      ) => begin
        @assign l_bc__str = AbsynDumpTpl.dumpPath(Tpl.emptyTxt, i_baseClassPath)
        @assign l_visibility__str = dumpVisibility(Tpl.emptyTxt, i_visibility)
        @assign l_mod__str = dumpModifier(Tpl.emptyTxt, i_modifications, a_options)
        @assign l_ann__str = dumpAnnotationOpt(Tpl.emptyTxt, i_ann, a_options)
        @assign txt = Tpl.writeText(txt, l_visibility__str)
        @assign txt = Tpl.writeTok(txt, Tpl.ST_STRING("extends "))
        @assign txt = Tpl.writeText(txt, l_bc__str)
        @assign txt = Tpl.writeText(txt, l_mod__str)
        @assign txt = Tpl.writeText(txt, l_ann__str)
        txt
      end

      (txt, _, _) => begin
        txt
      end
    end
  end
  return out_txt
end

function dumpClass(
  in_txt::Tpl.Text,
  in_a_class::SCode.Element,
  in_a_each::String,
  in_a_options::SCodeDump.SCodeDumpOptions,
)::Tpl.Text
  local out_txt::Tpl.Text

  @assign out_txt = begin
    local txt::Tpl.Text
    local a_each::String
    local a_options::SCodeDump.SCodeDumpOptions
    local i_name::SCode.Ident
    local i_cmt::SCode.Comment
    local i_classDef::SCode.ClassDef
    local i_restriction::SCode.Restriction
    local i_partialPrefix::SCode.Partial
    local i_encapsulatedPrefix::SCode.Encapsulated
    local i_prefixes::SCode.Prefixes
    local l_footer__str::Tpl.Text
    local l_header__str::Tpl.Text
    local l_cc__str::Tpl.Text
    local l_ann__str::Tpl.Text
    local l_cmt__str::Tpl.Text
    local l_cdef__str::Tpl.Text
    local l_prefixes__str::Tpl.Text
    local l_res__str::Tpl.Text
    local l_partial__str::Tpl.Text
    local l_enc__str::Tpl.Text
    local l_prefix__str::Tpl.Text
    @match (in_txt, in_a_class, in_a_each, in_a_options) begin
      (
        txt,
        SCode.CLASS(
          prefixes = i_prefixes,
          encapsulatedPrefix = i_encapsulatedPrefix,
          partialPrefix = i_partialPrefix,
          restriction = i_restriction,
          classDef = i_classDef,
          cmt = i_cmt,
          name = i_name,
        ),
        a_each,
        a_options,
      ) => begin
        @assign l_prefix__str = dumpPrefixes(Tpl.emptyTxt, i_prefixes, a_each)
        @assign l_enc__str = dumpEncapsulated(Tpl.emptyTxt, i_encapsulatedPrefix)
        @assign l_partial__str = dumpPartial(Tpl.emptyTxt, i_partialPrefix)
        @assign l_res__str = dumpRestriction(Tpl.emptyTxt, i_restriction)
        @assign l_prefixes__str = Tpl.writeText(Tpl.emptyTxt, l_prefix__str)
        @assign l_prefixes__str = Tpl.writeText(l_prefixes__str, l_enc__str)
        @assign l_prefixes__str = Tpl.writeText(l_prefixes__str, l_partial__str)
        @assign l_prefixes__str = Tpl.writeText(l_prefixes__str, l_res__str)
        @assign l_cdef__str = dumpClassDef(Tpl.emptyTxt, i_classDef, a_options)
        @assign l_cmt__str = dumpClassComment(Tpl.emptyTxt, i_cmt, a_options)
        @assign l_ann__str = dumpClassAnnotation(Tpl.emptyTxt, i_cmt, a_options)
        @assign l_cc__str =
          dumpReplaceableConstrainClass(Tpl.emptyTxt, i_prefixes, a_options)
        @assign l_header__str = dumpClassHeader(
          Tpl.emptyTxt,
          i_classDef,
          i_name,
          i_restriction,
          Tpl.textString(l_cmt__str),
          a_options,
        )
        @assign l_footer__str = dumpClassFooter(
          Tpl.emptyTxt,
          i_classDef,
          Tpl.textString(l_cdef__str),
          i_name,
          Tpl.textString(l_cmt__str),
          Tpl.textString(l_ann__str),
          Tpl.textString(l_cc__str),
        )
        @assign txt = Tpl.writeText(txt, l_prefixes__str)
        @assign txt = Tpl.writeTok(txt, Tpl.ST_STRING(" "))
        @assign txt = Tpl.writeText(txt, l_header__str)
        @assign txt = Tpl.writeTok(txt, Tpl.ST_STRING(" "))
        @assign txt = Tpl.writeText(txt, l_footer__str)
        txt
      end

      (txt, _, _, _) => begin
        txt
      end
    end
  end
  return out_txt
end

function dumpClassHeader(
  in_txt::Tpl.Text,
  in_a_classDef::SCode.ClassDef,
  in_a_name::String,
  in_a_restr::SCode.Restriction,
  in_a_cmt::String,
  in_a_options::SCodeDump.SCodeDumpOptions,
)::Tpl.Text
  local out_txt::Tpl.Text

  @assign out_txt = begin
    local txt::Tpl.Text
    local a_name::String
    local a_restr::SCode.Restriction
    local a_cmt::String
    local a_options::SCodeDump.SCodeDumpOptions
    local i_modifications::SCode.Mod
    local l_mod__str::Tpl.Text
    @match (in_txt, in_a_classDef, in_a_name, in_a_restr, in_a_cmt, in_a_options) begin
      (
        txt,
        SCode.CLASS_EXTENDS(modifications = i_modifications),
        a_name,
        _,
        a_cmt,
        a_options,
      ) => begin
        @assign l_mod__str = dumpModifier(Tpl.emptyTxt, i_modifications, a_options)
        @assign txt = Tpl.writeTok(txt, Tpl.ST_STRING("extends "))
        @assign txt = Tpl.writeStr(txt, a_name)
        @assign txt = Tpl.writeText(txt, l_mod__str)
        @assign txt = Tpl.writeTok(txt, Tpl.ST_STRING(" "))
        @assign txt = Tpl.writeStr(txt, a_cmt)
        txt
      end

      (txt, SCode.PARTS(elementLst = _), a_name, a_restr, a_cmt, _) => begin
        @assign txt = Tpl.writeStr(txt, a_name)
        @assign txt = dumpRestrictionTypeVars(txt, a_restr)
        @assign txt = Tpl.writeTok(txt, Tpl.ST_STRING(" "))
        @assign txt = Tpl.writeStr(txt, a_cmt)
        txt
      end

      (txt, _, a_name, _, _, _) => begin
        @assign txt = Tpl.writeStr(txt, a_name)
        txt
      end
    end
  end
  return out_txt
end

function fun_37(
  in_txt::Tpl.Text,
  in_a_options::SCodeDump.SCodeDumpOptions,
  in_a_p_normalAlgorithmLst::List{<:SCode.AlgorithmSection},
)::Tpl.Text
  local out_txt::Tpl.Text

  @assign out_txt = begin
    local txt::Tpl.Text
    local a_p_normalAlgorithmLst::List{SCode.AlgorithmSection}
    local i_options::SCodeDump.SCodeDumpOptions
    @match (in_txt, in_a_options, in_a_p_normalAlgorithmLst) begin
      (
        txt,
        i_options && SCodeDump.OPTIONS(stripAlgorithmSections = false),
        a_p_normalAlgorithmLst,
      ) => begin
        @assign txt =
          dumpAlgorithmSections(txt, a_p_normalAlgorithmLst, "algorithm", i_options)
        txt
      end

      (txt, _, _) => begin
        txt
      end
    end
  end
  return out_txt
end

function fun_38(
  in_txt::Tpl.Text,
  in_a_options::SCodeDump.SCodeDumpOptions,
  in_a_p_initialAlgorithmLst::List{<:SCode.AlgorithmSection},
)::Tpl.Text
  local out_txt::Tpl.Text

  @assign out_txt = begin
    local txt::Tpl.Text
    local a_p_initialAlgorithmLst::List{SCode.AlgorithmSection}
    local i_options::SCodeDump.SCodeDumpOptions
    @match (in_txt, in_a_options, in_a_p_initialAlgorithmLst) begin
      (
        txt,
        i_options && SCodeDump.OPTIONS(stripAlgorithmSections = false),
        a_p_initialAlgorithmLst,
      ) => begin
        @assign txt = dumpAlgorithmSections(
          txt,
          a_p_initialAlgorithmLst,
          "initial algorithm",
          i_options,
        )
        txt
      end

      (txt, _, _) => begin
        txt
      end
    end
  end
  return out_txt
end

function lm_39(
  in_txt::Tpl.Text,
  in_items::List{<:SCode.Enum},
  in_a_options::SCodeDump.SCodeDumpOptions,
)::Tpl.Text
  local out_txt::Tpl.Text

  @assign out_txt = begin
    local txt::Tpl.Text
    local rest::List{SCode.Enum}
    local a_options::SCodeDump.SCodeDumpOptions
    local i_enum::SCode.Enum
    @match (in_txt, in_items, in_a_options) begin
      (txt, nil(), _) => begin
        txt
      end

      (txt, i_enum <| rest, a_options) => begin
        @assign txt = dumpEnumLiteral(txt, i_enum, a_options)
        @assign txt = Tpl.nextIter(txt)
        @assign txt = lm_39(txt, rest, a_options)
        txt
      end
    end
  end
  return out_txt
end

function fun_40(
  in_txt::Tpl.Text,
  in_a_enumLst::List{<:SCode.Enum},
  in_a_options::SCodeDump.SCodeDumpOptions,
)::Tpl.Text
  local out_txt::Tpl.Text

  @assign out_txt = begin
    local txt::Tpl.Text
    local a_options::SCodeDump.SCodeDumpOptions
    local i_enumLst::List{SCode.Enum}
    @match (in_txt, in_a_enumLst, in_a_options) begin
      (txt, nil(), _) => begin
        @assign txt = Tpl.writeTok(txt, Tpl.ST_STRING(":"))
        txt
      end

      (txt, i_enumLst, a_options) => begin
        @assign txt = Tpl.pushIter(
          txt,
          Tpl.ITER_OPTIONS(
            0,
            NONE(),
            SOME(Tpl.ST_STRING(", ")),
            0,
            0,
            Tpl.ST_NEW_LINE(),
            0,
            Tpl.ST_NEW_LINE(),
          ),
        )
        @assign txt = lm_39(txt, i_enumLst, a_options)
        @assign txt = Tpl.popIter(txt)
        txt
      end
    end
  end
  return out_txt
end

function lm_41(in_txt::Tpl.Text, in_items::List{<:SCode.Ident})::Tpl.Text
  local out_txt::Tpl.Text

  @assign out_txt = begin
    local txt::Tpl.Text
    local rest::List{SCode.Ident}
    local i_it::SCode.Ident
    @match (in_txt, in_items) begin
      (txt, nil()) => begin
        txt
      end

      (txt, i_it <| rest) => begin
        @assign txt = Tpl.writeStr(txt, i_it)
        @assign txt = Tpl.nextIter(txt)
        @assign txt = lm_41(txt, rest)
        txt
      end
    end
  end
  return out_txt
end

function lm_42(in_txt::Tpl.Text, in_items::List{<:Absyn.Path})::Tpl.Text
  local out_txt::Tpl.Text

  @assign out_txt = begin
    local txt::Tpl.Text
    local rest::List{Absyn.Path}
    local i_path::Absyn.Path
    @match (in_txt, in_items) begin
      (txt, nil()) => begin
        txt
      end

      (txt, i_path <| rest) => begin
        @assign txt = AbsynDumpTpl.dumpPath(txt, i_path)
        @assign txt = Tpl.nextIter(txt)
        @assign txt = lm_42(txt, rest)
        txt
      end
    end
  end
  return out_txt
end

function dumpClassDef(
  in_txt::Tpl.Text,
  in_a_classDef::SCode.ClassDef,
  in_a_options::SCodeDump.SCodeDumpOptions,
)::Tpl.Text
  local out_txt::Tpl.Text

  @assign out_txt = begin
    local txt::Tpl.Text
    local a_options::SCodeDump.SCodeDumpOptions
    local i_pathLst::List{Absyn.Path}
    local i_derivedVariables::List{SCode.Ident}
    local i_functionPath::Absyn.Path
    local i_enumLst::List{SCode.Enum}
    local i_attributes::SCode.Attributes
    local i_typeSpec::Absyn.TypeSpec
    local i_composition::SCode.ClassDef
    local i_modifications::SCode.Mod
    local i_p_externalDecl::Option{SCode.ExternalDecl}
    local i_p_initialAlgorithmLst::List{SCode.AlgorithmSection}
    local i_p_normalAlgorithmLst::List{SCode.AlgorithmSection}
    local i_initialEquationLst::List{SCode.Equation}
    local i_normalEquationLst::List{SCode.Equation}
    local i_elementLst::List{SCode.Element}
    local l_func__str::Tpl.Text
    local l_enum__str::Tpl.Text
    local l_attr__str::Tpl.Text
    local l_type__str::Tpl.Text
    local l_mod__str::Tpl.Text
    local l_cdef__str::Tpl.Text
    local l_extdecl__str::Tpl.Text
    local l_ial__str::Tpl.Text
    local l_nal__str::Tpl.Text
    local l_ieq__str::Tpl.Text
    local l_neq__str::Tpl.Text
    local l_el__str::Tpl.Text
    @match (in_txt, in_a_classDef, in_a_options) begin
      (
        txt,
        SCode.PARTS(
          elementLst = i_elementLst,
          normalEquationLst = i_normalEquationLst,
          initialEquationLst = i_initialEquationLst,
          normalAlgorithmLst = i_p_normalAlgorithmLst,
          initialAlgorithmLst = i_p_initialAlgorithmLst,
          externalDecl = i_p_externalDecl,
        ),
        a_options,
      ) => begin
        @assign l_el__str = dumpElements(Tpl.emptyTxt, i_elementLst, true, a_options)
        @assign l_neq__str =
          dumpEquations(Tpl.emptyTxt, i_normalEquationLst, "equation", a_options)
        @assign l_ieq__str = dumpEquations(
          Tpl.emptyTxt,
          i_initialEquationLst,
          "initial equation",
          a_options,
        )
        @assign l_nal__str = fun_37(Tpl.emptyTxt, a_options, i_p_normalAlgorithmLst)
        @assign l_ial__str = fun_38(Tpl.emptyTxt, a_options, i_p_initialAlgorithmLst)
        @assign l_extdecl__str =
          dumpExternalDeclOpt(Tpl.emptyTxt, i_p_externalDecl, a_options)
        @assign l_cdef__str = Tpl.writeText(Tpl.emptyTxt, l_el__str)
        @assign l_cdef__str = Tpl.softNewLine(l_cdef__str)
        @assign l_cdef__str = Tpl.writeText(l_cdef__str, l_ieq__str)
        @assign l_cdef__str = Tpl.softNewLine(l_cdef__str)
        @assign l_cdef__str = Tpl.writeText(l_cdef__str, l_ial__str)
        @assign l_cdef__str = Tpl.softNewLine(l_cdef__str)
        @assign l_cdef__str = Tpl.writeText(l_cdef__str, l_neq__str)
        @assign l_cdef__str = Tpl.softNewLine(l_cdef__str)
        @assign l_cdef__str = Tpl.writeText(l_cdef__str, l_nal__str)
        @assign l_cdef__str = Tpl.softNewLine(l_cdef__str)
        @assign l_cdef__str = Tpl.pushBlock(l_cdef__str, Tpl.BT_INDENT(2))
        @assign l_cdef__str = Tpl.writeText(l_cdef__str, l_extdecl__str)
        @assign l_cdef__str = Tpl.popBlock(l_cdef__str)
        @assign txt = Tpl.writeText(txt, l_cdef__str)
        txt
      end

      (
        txt,
        SCode.CLASS_EXTENDS(modifications = i_modifications, composition = i_composition),
        a_options,
      ) => begin
        @assign l_mod__str = dumpModifier(Tpl.emptyTxt, i_modifications, a_options)
        @assign l_cdef__str = dumpClassDef(Tpl.emptyTxt, i_composition, a_options)
        @assign txt = Tpl.writeText(txt, l_cdef__str)
        txt
      end

      (
        txt,
        SCode.DERIVED(
          typeSpec = i_typeSpec,
          modifications = i_modifications,
          attributes = i_attributes,
        ),
        a_options,
      ) => begin
        @assign l_type__str = AbsynDumpTpl.dumpTypeSpec(Tpl.emptyTxt, i_typeSpec)
        @assign l_mod__str = dumpModifier(Tpl.emptyTxt, i_modifications, a_options)
        @assign l_attr__str = dumpAttributes(Tpl.emptyTxt, i_attributes)
        @assign txt = Tpl.writeTok(txt, Tpl.ST_STRING("= "))
        @assign txt = Tpl.writeText(txt, l_attr__str)
        @assign txt = Tpl.writeText(txt, l_type__str)
        @assign txt = Tpl.writeText(txt, l_mod__str)
        txt
      end

      (txt, SCode.ENUMERATION(enumLst = i_enumLst), a_options) => begin
        @assign l_enum__str = fun_40(Tpl.emptyTxt, i_enumLst, a_options)
        @assign txt = Tpl.writeTok(txt, Tpl.ST_STRING("= enumeration("))
        @assign txt = Tpl.writeText(txt, l_enum__str)
        @assign txt = Tpl.writeTok(txt, Tpl.ST_STRING(")"))
        txt
      end

      (
        txt,
        SCode.PDER(functionPath = i_functionPath, derivedVariables = i_derivedVariables),
        _,
      ) => begin
        @assign l_func__str = AbsynDumpTpl.dumpPath(Tpl.emptyTxt, i_functionPath)
        @assign txt = Tpl.writeTok(txt, Tpl.ST_STRING("= der("))
        @assign txt = Tpl.writeText(txt, l_func__str)
        @assign txt = Tpl.writeTok(txt, Tpl.ST_STRING(", "))
        @assign txt = Tpl.pushIter(
          txt,
          Tpl.ITER_OPTIONS(
            0,
            NONE(),
            SOME(Tpl.ST_STRING(", ")),
            0,
            0,
            Tpl.ST_NEW_LINE(),
            0,
            Tpl.ST_NEW_LINE(),
          ),
        )
        @assign txt = lm_41(txt, i_derivedVariables)
        @assign txt = Tpl.popIter(txt)
        @assign txt = Tpl.writeTok(txt, Tpl.ST_STRING(")"))
        txt
      end

      (txt, SCode.OVERLOAD(pathLst = i_pathLst), _) => begin
        @assign txt = Tpl.writeTok(txt, Tpl.ST_STRING("= overload("))
        @assign txt = Tpl.pushIter(
          txt,
          Tpl.ITER_OPTIONS(
            0,
            NONE(),
            SOME(Tpl.ST_STRING(", ")),
            0,
            0,
            Tpl.ST_NEW_LINE(),
            0,
            Tpl.ST_NEW_LINE(),
          ),
        )
        @assign txt = lm_42(txt, i_pathLst)
        @assign txt = Tpl.popIter(txt)
        @assign txt = Tpl.writeTok(txt, Tpl.ST_STRING(")"))
        txt
      end

      (txt, _, _) => begin
        @assign txt = errorMsg(txt, "SCodeDump.dumpClassDef: Unknown class definition.")
        txt
      end
    end
  end
  return out_txt
end

function fun_44(in_txt::Tpl.Text, in_a_ann::String)::Tpl.Text
  local out_txt::Tpl.Text

  @assign out_txt = begin
    local txt::Tpl.Text
    local i_ann::String
    @match (in_txt, in_a_ann) begin
      (txt, "") => begin
        txt
      end

      (txt, i_ann) => begin
        @assign txt = Tpl.writeStr(txt, i_ann)
        @assign txt = Tpl.writeTok(txt, Tpl.ST_STRING("; "))
        txt
      end
    end
  end
  return out_txt
end

function fun_45(in_txt::Tpl.Text, in_a_annstr::Tpl.Text)::Tpl.Text
  local out_txt::Tpl.Text

  @assign out_txt = begin
    local txt::Tpl.Text
    @match (in_txt, in_a_annstr) begin
      (txt, Tpl.MEM_TEXT(tokens = nil())) => begin
        txt
      end

      (txt, _) => begin
        @assign txt = Tpl.writeTok(txt, Tpl.ST_STRING(" "))
        txt
      end
    end
  end
  return out_txt
end

function fun_46(
  in_txt::Tpl.Text,
  in_a_cdefStr::String,
  in_a_cc__str::String,
  in_a_name::String,
  in_a_annstr::Tpl.Text,
)::Tpl.Text
  local out_txt::Tpl.Text

  @assign out_txt = begin
    local txt::Tpl.Text
    local a_cc__str::String
    local a_name::String
    local a_annstr::Tpl.Text
    local i_cdefStr::String
    @match (in_txt, in_a_cdefStr, in_a_cc__str, in_a_name, in_a_annstr) begin
      (txt, "", a_cc__str, a_name, a_annstr) => begin
        @assign txt = Tpl.writeText(txt, a_annstr)
        @assign txt = Tpl.writeTok(txt, Tpl.ST_STRING("end "))
        @assign txt = Tpl.writeStr(txt, a_name)
        @assign txt = Tpl.writeStr(txt, a_cc__str)
        txt
      end

      (txt, i_cdefStr, a_cc__str, a_name, a_annstr) => begin
        @assign txt = Tpl.writeTok(txt, Tpl.ST_NEW_LINE())
        @assign txt = Tpl.writeStr(txt, i_cdefStr)
        @assign txt = Tpl.softNewLine(txt)
        @assign txt = fun_45(txt, a_annstr)
        @assign txt = Tpl.writeText(txt, a_annstr)
        @assign txt = Tpl.softNewLine(txt)
        @assign txt = Tpl.writeTok(txt, Tpl.ST_STRING("end "))
        @assign txt = Tpl.writeStr(txt, a_name)
        @assign txt = Tpl.writeStr(txt, a_cc__str)
        txt
      end
    end
  end
  return out_txt
end

function dumpClassFooter(
  in_txt::Tpl.Text,
  in_a_classDef::SCode.ClassDef,
  in_a_cdefStr::String,
  in_a_name::String,
  in_a_cmt::String,
  in_a_ann::String,
  in_a_cc__str::String,
)::Tpl.Text
  local out_txt::Tpl.Text

  @assign out_txt = begin
    local txt::Tpl.Text
    local a_cdefStr::String
    local a_name::String
    local a_cmt::String
    local a_ann::String
    local a_cc__str::String
    local l_annstr::Tpl.Text
    @match (
      in_txt,
      in_a_classDef,
      in_a_cdefStr,
      in_a_name,
      in_a_cmt,
      in_a_ann,
      in_a_cc__str,
    ) begin
      (txt, SCode.DERIVED(typeSpec = _), a_cdefStr, _, a_cmt, a_ann, a_cc__str) => begin
        @assign txt = Tpl.writeStr(txt, a_cdefStr)
        @assign txt = Tpl.writeStr(txt, a_cmt)
        @assign txt = Tpl.writeStr(txt, a_ann)
        @assign txt = Tpl.writeStr(txt, a_cc__str)
        txt
      end

      (txt, SCode.ENUMERATION(enumLst = _), a_cdefStr, _, a_cmt, a_ann, a_cc__str) =>
        begin
          @assign txt = Tpl.writeStr(txt, a_cdefStr)
          @assign txt = Tpl.writeStr(txt, a_cmt)
          @assign txt = Tpl.writeStr(txt, a_ann)
          @assign txt = Tpl.writeStr(txt, a_cc__str)
          txt
        end

      (txt, SCode.PDER(functionPath = _), a_cdefStr, _, _, _, _) => begin
        @assign txt = Tpl.writeStr(txt, a_cdefStr)
        txt
      end

      (txt, _, a_cdefStr, a_name, _, a_ann, a_cc__str) => begin
        @assign l_annstr = fun_44(Tpl.emptyTxt, a_ann)
        @assign txt = fun_46(txt, a_cdefStr, a_cc__str, a_name, l_annstr)
        txt
      end
    end
  end
  return out_txt
end

function dumpClassComment(
  in_txt::Tpl.Text,
  in_a_comment::SCode.Comment,
  in_a_options::SCodeDump.SCodeDumpOptions,
)::Tpl.Text
  local out_txt::Tpl.Text

  @assign out_txt = begin
    local txt::Tpl.Text
    local a_options::SCodeDump.SCodeDumpOptions
    local i_comment::Option{String}
    @match (in_txt, in_a_comment, in_a_options) begin
      (txt, SCode.COMMENT(comment = i_comment), a_options) => begin
        @assign txt = dumpCommentStr(txt, i_comment, a_options)
        txt
      end

      (txt, _, _) => begin
        txt
      end
    end
  end
  return out_txt
end

function dumpClassAnnotation(
  in_txt::Tpl.Text,
  in_a_comment::SCode.Comment,
  in_a_options::SCodeDump.SCodeDumpOptions,
)::Tpl.Text
  local out_txt::Tpl.Text

  @assign out_txt = begin
    local txt::Tpl.Text
    local a_options::SCodeDump.SCodeDumpOptions
    local i_annotation__::Option{SCode.Annotation}
    @match (in_txt, in_a_comment, in_a_options) begin
      (txt, SCode.COMMENT(annotation_ = i_annotation__), a_options) => begin
        @assign txt = dumpAnnotationOpt(txt, i_annotation__, a_options)
        txt
      end

      (txt, _, _) => begin
        txt
      end
    end
  end
  return out_txt
end

function fun_50(
  in_txt::Tpl.Text,
  in_a_attributes::SCode.Attributes,
  in_a_mod__str1::Tpl.Text,
)::Tpl.Text
  local out_txt::Tpl.Text

  @assign out_txt = begin
    local txt::Tpl.Text
    local a_mod__str1::Tpl.Text
    @match (in_txt, in_a_attributes, in_a_mod__str1) begin
      (txt, SCode.ATTR(direction = Absyn.OUTPUT(__)), _) => begin
        txt
      end

      (txt, _, a_mod__str1) => begin
        @assign txt = Tpl.writeText(txt, a_mod__str1)
        txt
      end
    end
  end
  return out_txt
end

function fun_51(
  in_txt::Tpl.Text,
  in_a_options::SCodeDump.SCodeDumpOptions,
  in_a_attributes::SCode.Attributes,
  in_a_mod__str1::Tpl.Text,
)::Tpl.Text
  local out_txt::Tpl.Text

  @assign out_txt = begin
    local txt::Tpl.Text
    local a_attributes::SCode.Attributes
    local a_mod__str1::Tpl.Text
    @match (in_txt, in_a_options, in_a_attributes, in_a_mod__str1) begin
      (txt, SCodeDump.OPTIONS(stripOutputBindings = false), _, a_mod__str1) => begin
        @assign txt = Tpl.writeText(txt, a_mod__str1)
        txt
      end

      (txt, _, a_attributes, a_mod__str1) => begin
        @assign txt = fun_50(txt, a_attributes, a_mod__str1)
        txt
      end
    end
  end
  return out_txt
end

function fun_52(in_txt::Tpl.Text, in_a_condition::Option{<:Absyn.Exp})::Tpl.Text
  local out_txt::Tpl.Text

  @assign out_txt = begin
    local txt::Tpl.Text
    local i_cond::Absyn.Exp
    @match (in_txt, in_a_condition) begin
      (txt, SOME(i_cond)) => begin
        @assign txt = Tpl.pushBlock(txt, Tpl.BT_INDENT(1))
        @assign txt = Tpl.writeTok(txt, Tpl.ST_STRING("if "))
        @assign txt = AbsynDumpTpl.dumpExp(txt, i_cond)
        @assign txt = Tpl.popBlock(txt)
        txt
      end

      (txt, _) => begin
        txt
      end
    end
  end
  return out_txt
end

function dumpComponent(
  in_txt::Tpl.Text,
  in_a_component::SCode.Element,
  in_a_each::String,
  in_a_options::SCodeDump.SCodeDumpOptions,
)::Tpl.Text
  local out_txt::Tpl.Text

  @assign out_txt = begin
    local txt::Tpl.Text
    local a_each::String
    local a_options::SCodeDump.SCodeDumpOptions
    local i_name::SCode.Ident
    local i_comment::SCode.Comment
    local i_condition::Option{Absyn.Exp}
    local i_modifications::SCode.Mod
    local i_typeSpec::Absyn.TypeSpec
    local i_attributes::SCode.Attributes
    local i_prefixes::SCode.Prefixes
    local l_cmt__str::Tpl.Text
    local l_cond__str::Tpl.Text
    local l_mod__str::Tpl.Text
    local l_mod__str1::Tpl.Text
    local l_type__str::Tpl.Text
    local l_attr__dim__str::Tpl.Text
    local l_attr__pre__str::Tpl.Text
    local l_cc__str::Tpl.Text
    local l_prefix__str::Tpl.Text
    @match (in_txt, in_a_component, in_a_each, in_a_options) begin
      (
        txt,
        SCode.COMPONENT(
          prefixes = i_prefixes,
          attributes = i_attributes,
          typeSpec = i_typeSpec,
          modifications = i_modifications,
          condition = i_condition,
          comment = i_comment,
          name = i_name,
        ),
        a_each,
        a_options,
      ) => begin
        @assign l_prefix__str = dumpPrefixes(Tpl.emptyTxt, i_prefixes, a_each)
        @assign l_cc__str =
          dumpReplaceableConstrainClass(Tpl.emptyTxt, i_prefixes, a_options)
        @assign l_attr__pre__str = dumpAttributes(Tpl.emptyTxt, i_attributes)
        @assign l_attr__dim__str = dumpAttributeDim(Tpl.emptyTxt, i_attributes)
        @assign l_type__str = AbsynDumpTpl.dumpTypeSpec(Tpl.emptyTxt, i_typeSpec)
        @assign l_mod__str1 = dumpModifier(Tpl.emptyTxt, i_modifications, a_options)
        @assign l_mod__str = fun_51(Tpl.emptyTxt, a_options, i_attributes, l_mod__str1)
        @assign l_cond__str = fun_52(Tpl.emptyTxt, i_condition)
        @assign l_cmt__str = dumpComment(Tpl.emptyTxt, i_comment, a_options)
        @assign txt = Tpl.writeText(txt, l_prefix__str)
        @assign txt = Tpl.writeText(txt, l_attr__pre__str)
        @assign txt = Tpl.writeText(txt, l_type__str)
        @assign txt = Tpl.writeText(txt, l_attr__dim__str)
        @assign txt = Tpl.writeTok(txt, Tpl.ST_STRING(" "))
        @assign txt = Tpl.writeStr(txt, i_name)
        @assign txt = Tpl.writeText(txt, l_mod__str)
        @assign txt = Tpl.writeText(txt, l_cond__str)
        @assign txt = Tpl.writeText(txt, l_cc__str)
        @assign txt = Tpl.writeText(txt, l_cmt__str)
        txt
      end

      (txt, _, _, _) => begin
        txt
      end
    end
  end
  return out_txt
end

function fun_54(in_txt::Tpl.Text, in_a_exp::Option{<:String})::Tpl.Text
  local out_txt::Tpl.Text

  @assign out_txt = begin
    local txt::Tpl.Text
    local i_e::String
    @match (in_txt, in_a_exp) begin
      (txt, SOME(i_e)) => begin
        @assign txt = Tpl.writeTok(txt, Tpl.ST_STRING("exp = \\"))
        @assign txt = Tpl.writeStr(txt, i_e)
        @assign txt = Tpl.writeTok(txt, Tpl.ST_STRING("\\"))
        txt
      end

      (txt, _) => begin
        txt
      end
    end
  end
  return out_txt
end

function fun_55(in_txt::Tpl.Text, in_a_weight::Option{<:AbstractFloat})::Tpl.Text
  local out_txt::Tpl.Text

  @assign out_txt = begin
    local txt::Tpl.Text
    local i_w::AbstractFloat
    @match (in_txt, in_a_weight) begin
      (txt, SOME(i_w)) => begin
        @assign txt = Tpl.writeTok(txt, Tpl.ST_STRING("weight = "))
        @assign txt = Tpl.writeStr(txt, realString(i_w))
        txt
      end

      (txt, _) => begin
        txt
      end
    end
  end
  return out_txt
end

function smf_56(in_txt::Tpl.Text, in_it::Tpl.Text)::Tpl.Text
  local out_txt::Tpl.Text

  @assign out_txt = begin
    local txt::Tpl.Text
    local i_it::Tpl.Text
    @match (in_txt, in_it) begin
      (txt, i_it) => begin
        @assign txt = Tpl.writeText(txt, i_it)
        @assign txt = Tpl.nextIter(txt)
        txt
      end
    end
  end
  return out_txt
end

function smf_57(in_txt::Tpl.Text, in_it::Tpl.Text)::Tpl.Text
  local out_txt::Tpl.Text

  @assign out_txt = begin
    local txt::Tpl.Text
    local i_it::Tpl.Text
    @match (in_txt, in_it) begin
      (txt, i_it) => begin
        @assign txt = Tpl.writeText(txt, i_it)
        @assign txt = Tpl.nextIter(txt)
        txt
      end
    end
  end
  return out_txt
end

function fun_58(in_txt::Tpl.Text, in_a_args__str::Tpl.Text)::Tpl.Text
  local out_txt::Tpl.Text

  @assign out_txt = begin
    local txt::Tpl.Text
    @match (in_txt, in_a_args__str) begin
      (txt, Tpl.MEM_TEXT(tokens = nil())) => begin
        txt
      end

      (txt, _) => begin
        @assign txt = Tpl.writeTok(txt, Tpl.ST_STRING("("))
        txt
      end
    end
  end
  return out_txt
end

function fun_59(in_txt::Tpl.Text, in_a_args__str::Tpl.Text)::Tpl.Text
  local out_txt::Tpl.Text

  @assign out_txt = begin
    local txt::Tpl.Text
    @match (in_txt, in_a_args__str) begin
      (txt, Tpl.MEM_TEXT(tokens = nil())) => begin
        txt
      end

      (txt, _) => begin
        @assign txt = Tpl.writeTok(txt, Tpl.ST_STRING(")"))
        txt
      end
    end
  end
  return out_txt
end

function dumpDefineUnit(in_txt::Tpl.Text, in_a_defineUnit::SCode.Element)::Tpl.Text
  local out_txt::Tpl.Text

  @assign out_txt = begin
    local txt::Tpl.Text
    local i_name::SCode.Ident
    local i_weight::Option{AbstractFloat}
    local i_exp::Option{String}
    local i_visibility::SCode.Visibility
    local l_pe::Tpl.Text
    local l_pb::Tpl.Text
    local l_args__str::Tpl.Text
    local l_weight__str::Tpl.Text
    local l_exp__str::Tpl.Text
    local l_vis__str::Tpl.Text
    @match (in_txt, in_a_defineUnit) begin
      (
        txt,
        SCode.DEFINEUNIT(
          visibility = i_visibility,
          exp = i_exp,
          weight = i_weight,
          name = i_name,
        ),
      ) => begin
        @assign l_vis__str = dumpVisibility(Tpl.emptyTxt, i_visibility)
        @assign l_exp__str = fun_54(Tpl.emptyTxt, i_exp)
        @assign l_weight__str = fun_55(Tpl.emptyTxt, i_weight)
        @assign l_args__str = Tpl.pushIter(
          Tpl.emptyTxt,
          Tpl.ITER_OPTIONS(
            0,
            NONE(),
            SOME(Tpl.ST_STRING(", ")),
            0,
            0,
            Tpl.ST_NEW_LINE(),
            0,
            Tpl.ST_NEW_LINE(),
          ),
        )
        @assign l_args__str = smf_56(l_args__str, l_exp__str)
        @assign l_args__str = smf_57(l_args__str, l_weight__str)
        @assign l_args__str = Tpl.popIter(l_args__str)
        @assign l_pb = fun_58(Tpl.emptyTxt, l_args__str)
        @assign l_pe = fun_59(Tpl.emptyTxt, l_args__str)
        @assign txt = Tpl.writeTok(txt, Tpl.ST_STRING("defineunit "))
        @assign txt = Tpl.writeStr(txt, i_name)
        @assign txt = Tpl.writeText(txt, l_pb)
        @assign txt = Tpl.writeText(txt, l_args__str)
        @assign txt = Tpl.writeText(txt, l_pe)
        txt
      end

      (txt, _) => begin
        txt
      end
    end
  end
  return out_txt
end

function dumpEnumLiteral(
  in_txt::Tpl.Text,
  in_a_enum::SCode.Enum,
  in_a_options::SCodeDump.SCodeDumpOptions,
)::Tpl.Text
  local out_txt::Tpl.Text

  @assign out_txt = begin
    local txt::Tpl.Text
    local a_options::SCodeDump.SCodeDumpOptions
    local i_literal::SCode.Ident
    local i_comment::SCode.Comment
    local l_cmt__str::Tpl.Text
    @match (in_txt, in_a_enum, in_a_options) begin
      (txt, SCode.ENUM(comment = i_comment, literal = i_literal), a_options) => begin
        @assign l_cmt__str = dumpComment(Tpl.emptyTxt, i_comment, a_options)
        @assign txt = Tpl.writeStr(txt, i_literal)
        @assign txt = Tpl.writeText(txt, l_cmt__str)
        txt
      end

      (txt, _, _) => begin
        txt
      end
    end
  end
  return out_txt
end

function lm_62(
  in_txt::Tpl.Text,
  in_items::List{<:SCode.Equation},
  in_a_options::SCodeDump.SCodeDumpOptions,
)::Tpl.Text
  local out_txt::Tpl.Text

  @assign out_txt = begin
    local txt::Tpl.Text
    local rest::List{SCode.Equation}
    local a_options::SCodeDump.SCodeDumpOptions
    local i_eq::SCode.Equation
    @match (in_txt, in_items, in_a_options) begin
      (txt, nil(), _) => begin
        txt
      end

      (txt, i_eq <| rest, a_options) => begin
        @assign txt = dumpEquation(txt, i_eq, a_options)
        @assign txt = Tpl.nextIter(txt)
        @assign txt = lm_62(txt, rest, a_options)
        txt
      end
    end
  end
  return out_txt
end

function dumpEquations(
  in_txt::Tpl.Text,
  in_a_equations::List{<:SCode.Equation},
  in_a_label::String,
  in_a_options::SCodeDump.SCodeDumpOptions,
)::Tpl.Text
  local out_txt::Tpl.Text

  @assign out_txt = begin
    local txt::Tpl.Text
    local a_label::String
    local a_options::SCodeDump.SCodeDumpOptions
    local i_equations::List{SCode.Equation}
    @match (in_txt, in_a_equations, in_a_label, in_a_options) begin
      (txt, nil(), _, _) => begin
        txt
      end

      (txt, i_equations, a_label, a_options) => begin
        @assign txt = Tpl.writeStr(txt, a_label)
        @assign txt = Tpl.softNewLine(txt)
        @assign txt = Tpl.pushBlock(txt, Tpl.BT_INDENT(2))
        @assign txt = Tpl.pushIter(
          txt,
          Tpl.ITER_OPTIONS(
            0,
            NONE(),
            SOME(Tpl.ST_NEW_LINE()),
            0,
            0,
            Tpl.ST_NEW_LINE(),
            0,
            Tpl.ST_NEW_LINE(),
          ),
        )
        @assign txt = lm_62(txt, i_equations, a_options)
        @assign txt = Tpl.popIter(txt)
        @assign txt = Tpl.popBlock(txt)
        txt
      end
    end
  end
  return out_txt
end

function dumpEquation(
  in_txt::Tpl.Text,
  in_a_equation::SCode.Equation,
  in_a_options::SCodeDump.SCodeDumpOptions,
)::Tpl.Text
  local out_txt::Tpl.Text

  @assign out_txt = begin
    local txt::Tpl.Text
    local a_options::SCodeDump.SCodeDumpOptions
    local i_eEquation::SCode.EEquation
    @match (in_txt, in_a_equation, in_a_options) begin
      (txt, SCode.EQUATION(eEquation = i_eEquation), a_options) => begin
        @assign txt = dumpEEquation(txt, i_eEquation, a_options)
        txt
      end

      (txt, _, _) => begin
        txt
      end
    end
  end
  return out_txt
end

function dumpEEquation(
  in_txt::Tpl.Text,
  in_a_equation::SCode.EEquation,
  in_a_options::SCodeDump.SCodeDumpOptions,
)::Tpl.Text
  local out_txt::Tpl.Text

  @assign out_txt = begin
    local txt::Tpl.Text
    local a_options::SCodeDump.SCodeDumpOptions
    local i_exp::Absyn.Exp
    local i_expReinit::Absyn.Exp
    local i_cref::Absyn.Exp
    local i_level::Absyn.Exp
    local i_message::Absyn.Exp
    local i_condition::Absyn.Exp
    local i_crefRight::Absyn.ComponentRef
    local i_crefLeft::Absyn.ComponentRef
    local i_comment::SCode.Comment
    local i_expRight::Absyn.Exp
    local i_expLeft::Absyn.Exp
    local i_equation::SCode.EEquation
    local l_exp__str::Tpl.Text
    local l_cref__str::Tpl.Text
    local l_lvl__str::Tpl.Text
    local l_msg__str::Tpl.Text
    local l_cond__str::Tpl.Text
    local l_cmt__str::Tpl.Text
    local l_rhs__str::Tpl.Text
    local l_lhs__str::Tpl.Text
    @match (in_txt, in_a_equation, in_a_options) begin
      (txt, i_equation && SCode.EQ_IF(condition = _), a_options) => begin
        @assign txt = dumpIfEEquation(txt, i_equation, a_options)
        txt
      end

      (
        txt,
        SCode.EQ_EQUALS(expLeft = i_expLeft, expRight = i_expRight, comment = i_comment),
        a_options,
      ) => begin
        @assign l_lhs__str = AbsynDumpTpl.dumpLhsExp(Tpl.emptyTxt, i_expLeft)
        @assign l_rhs__str = AbsynDumpTpl.dumpExp(Tpl.emptyTxt, i_expRight)
        @assign l_cmt__str = dumpComment(Tpl.emptyTxt, i_comment, a_options)
        @assign txt = Tpl.writeText(txt, l_lhs__str)
        @assign txt = Tpl.writeTok(txt, Tpl.ST_STRING(" = "))
        @assign txt = Tpl.writeText(txt, l_rhs__str)
        @assign txt = Tpl.writeText(txt, l_cmt__str)
        @assign txt = Tpl.writeTok(txt, Tpl.ST_STRING(";"))
        txt
      end

      (
        txt,
        SCode.EQ_CONNECT(
          crefLeft = i_crefLeft,
          crefRight = i_crefRight,
          comment = i_comment,
        ),
        a_options,
      ) => begin
        @assign l_lhs__str = AbsynDumpTpl.dumpCref(Tpl.emptyTxt, i_crefLeft)
        @assign l_rhs__str = AbsynDumpTpl.dumpCref(Tpl.emptyTxt, i_crefRight)
        @assign l_cmt__str = dumpComment(Tpl.emptyTxt, i_comment, a_options)
        @assign txt = Tpl.writeTok(txt, Tpl.ST_STRING("connect("))
        @assign txt = Tpl.writeText(txt, l_lhs__str)
        @assign txt = Tpl.writeTok(txt, Tpl.ST_STRING(", "))
        @assign txt = Tpl.writeText(txt, l_rhs__str)
        @assign txt = Tpl.writeTok(txt, Tpl.ST_STRING(")"))
        @assign txt = Tpl.writeText(txt, l_cmt__str)
        @assign txt = Tpl.writeTok(txt, Tpl.ST_STRING(";"))
        txt
      end

      (txt, i_equation && SCode.EQ_FOR(index = _), a_options) => begin
        @assign txt = dumpForEEquation(txt, i_equation, a_options)
        txt
      end

      (txt, i_equation && SCode.EQ_WHEN(condition = _), a_options) => begin
        @assign txt = dumpWhenEEquation(txt, i_equation, a_options)
        txt
      end

      (
        txt,
        SCode.EQ_ASSERT(
          condition = i_condition,
          message = i_message,
          level = i_level,
          comment = i_comment,
        ),
        a_options,
      ) => begin
        @assign l_cond__str = AbsynDumpTpl.dumpExp(Tpl.emptyTxt, i_condition)
        @assign l_msg__str = AbsynDumpTpl.dumpExp(Tpl.emptyTxt, i_message)
        @assign l_lvl__str = dumpAssertionLevel(Tpl.emptyTxt, i_level)
        @assign l_cmt__str = dumpComment(Tpl.emptyTxt, i_comment, a_options)
        @assign txt = Tpl.writeTok(txt, Tpl.ST_STRING("assert("))
        @assign txt = Tpl.writeText(txt, l_cond__str)
        @assign txt = Tpl.writeTok(txt, Tpl.ST_STRING(", "))
        @assign txt = Tpl.writeText(txt, l_msg__str)
        @assign txt = Tpl.writeText(txt, l_lvl__str)
        @assign txt = Tpl.writeTok(txt, Tpl.ST_STRING(")"))
        @assign txt = Tpl.writeText(txt, l_cmt__str)
        @assign txt = Tpl.writeTok(txt, Tpl.ST_STRING(";"))
        txt
      end

      (txt, SCode.EQ_TERMINATE(message = i_message, comment = i_comment), a_options) =>
        begin
          @assign l_msg__str = AbsynDumpTpl.dumpExp(Tpl.emptyTxt, i_message)
          @assign l_cmt__str = dumpComment(Tpl.emptyTxt, i_comment, a_options)
          @assign txt = Tpl.writeTok(txt, Tpl.ST_STRING("terminate("))
          @assign txt = Tpl.writeText(txt, l_msg__str)
          @assign txt = Tpl.writeTok(txt, Tpl.ST_STRING(")"))
          @assign txt = Tpl.writeText(txt, l_cmt__str)
          @assign txt = Tpl.writeTok(txt, Tpl.ST_STRING(";"))
          txt
        end

      (
        txt,
        SCode.EQ_REINIT(cref = i_cref, expReinit = i_expReinit, comment = i_comment),
        a_options,
      ) => begin
        @assign l_cref__str = AbsynDumpTpl.dumpExp(Tpl.emptyTxt, i_cref)
        @assign l_exp__str = AbsynDumpTpl.dumpExp(Tpl.emptyTxt, i_expReinit)
        @assign l_cmt__str = dumpComment(Tpl.emptyTxt, i_comment, a_options)
        @assign txt = Tpl.writeTok(txt, Tpl.ST_STRING("reinit("))
        @assign txt = Tpl.writeText(txt, l_cref__str)
        @assign txt = Tpl.writeTok(txt, Tpl.ST_STRING(", "))
        @assign txt = Tpl.writeText(txt, l_exp__str)
        @assign txt = Tpl.writeTok(txt, Tpl.ST_STRING(")"))
        @assign txt = Tpl.writeText(txt, l_cmt__str)
        @assign txt = Tpl.writeTok(txt, Tpl.ST_STRING(";"))
        txt
      end

      (txt, SCode.EQ_NORETCALL(exp = i_exp, comment = i_comment), a_options) => begin
        @assign l_exp__str = AbsynDumpTpl.dumpExp(Tpl.emptyTxt, i_exp)
        @assign l_cmt__str = dumpComment(Tpl.emptyTxt, i_comment, a_options)
        @assign txt = Tpl.writeText(txt, l_exp__str)
        @assign txt = Tpl.writeText(txt, l_cmt__str)
        @assign txt = Tpl.writeTok(txt, Tpl.ST_STRING(";"))
        txt
      end

      (txt, _, _) => begin
        @assign txt = errorMsg(txt, "SCodeDump.dumpEEquation: Unknown EEquation.")
        txt
      end
    end
  end
  return out_txt
end

function lm_66(
  in_txt::Tpl.Text,
  in_items::List{<:SCode.EEquation},
  in_a_options::SCodeDump.SCodeDumpOptions,
)::Tpl.Text
  local out_txt::Tpl.Text

  @assign out_txt = begin
    local txt::Tpl.Text
    local rest::List{SCode.EEquation}
    local a_options::SCodeDump.SCodeDumpOptions
    local i_e::SCode.EEquation
    @match (in_txt, in_items, in_a_options) begin
      (txt, nil(), _) => begin
        txt
      end

      (txt, i_e <| rest, a_options) => begin
        @assign txt = dumpEEquation(txt, i_e, a_options)
        @assign txt = Tpl.nextIter(txt)
        @assign txt = lm_66(txt, rest, a_options)
        txt
      end
    end
  end
  return out_txt
end

function lm_67(
  in_txt::Tpl.Text,
  in_items::List{<:SCode.EEquation},
  in_a_options::SCodeDump.SCodeDumpOptions,
)::Tpl.Text
  local out_txt::Tpl.Text

  @assign out_txt = begin
    local txt::Tpl.Text
    local rest::List{SCode.EEquation}
    local a_options::SCodeDump.SCodeDumpOptions
    local i_e::SCode.EEquation
    @match (in_txt, in_items, in_a_options) begin
      (txt, nil(), _) => begin
        txt
      end

      (txt, i_e <| rest, a_options) => begin
        @assign txt = dumpEEquation(txt, i_e, a_options)
        @assign txt = Tpl.nextIter(txt)
        @assign txt = lm_67(txt, rest, a_options)
        txt
      end
    end
  end
  return out_txt
end

function fun_68(
  in_txt::Tpl.Text,
  in_a_elseBranch::List{<:SCode.EEquation},
  in_a_options::SCodeDump.SCodeDumpOptions,
)::Tpl.Text
  local out_txt::Tpl.Text

  @assign out_txt = begin
    local txt::Tpl.Text
    local a_options::SCodeDump.SCodeDumpOptions
    local i_elseBranch::List{SCode.EEquation}
    @match (in_txt, in_a_elseBranch, in_a_options) begin
      (txt, nil(), _) => begin
        txt
      end

      (txt, i_elseBranch, a_options) => begin
        @assign txt = Tpl.writeTok(txt, Tpl.ST_LINE("else\\n"))
        @assign txt = Tpl.pushBlock(txt, Tpl.BT_INDENT(2))
        @assign txt = Tpl.pushIter(
          txt,
          Tpl.ITER_OPTIONS(
            0,
            NONE(),
            SOME(Tpl.ST_NEW_LINE()),
            0,
            0,
            Tpl.ST_NEW_LINE(),
            0,
            Tpl.ST_NEW_LINE(),
          ),
        )
        @assign txt = lm_67(txt, i_elseBranch, a_options)
        @assign txt = Tpl.popIter(txt)
        @assign txt = Tpl.popBlock(txt)
        txt
      end
    end
  end
  return out_txt
end

function dumpIfEEquation(
  in_txt::Tpl.Text,
  in_a_ifequation::SCode.EEquation,
  in_a_options::SCodeDump.SCodeDumpOptions,
)::Tpl.Text
  local out_txt::Tpl.Text

  @assign out_txt = begin
    local txt::Tpl.Text
    local a_options::SCodeDump.SCodeDumpOptions
    local i_elseBranch::List{SCode.EEquation}
    local i_elseif__branches::List{List{SCode.EEquation}}
    local i_elseif__conds::List{Absyn.Exp}
    local i_if__branch::List{SCode.EEquation}
    local i_if__cond::Absyn.Exp
    local l_else__str::Tpl.Text
    local l_elseif__str::Tpl.Text
    local l_if__branch__str::Tpl.Text
    local l_if__cond__str::Tpl.Text
    @match (in_txt, in_a_ifequation, in_a_options) begin
      (
        txt,
        SCode.EQ_IF(
          condition = i_if__cond <| i_elseif__conds,
          thenBranch = i_if__branch <| i_elseif__branches,
          elseBranch = i_elseBranch,
        ),
        a_options,
      ) => begin
        @assign l_if__cond__str = AbsynDumpTpl.dumpExp(Tpl.emptyTxt, i_if__cond)
        @assign l_if__branch__str = Tpl.pushIter(
          Tpl.emptyTxt,
          Tpl.ITER_OPTIONS(
            0,
            NONE(),
            SOME(Tpl.ST_NEW_LINE()),
            0,
            0,
            Tpl.ST_NEW_LINE(),
            0,
            Tpl.ST_NEW_LINE(),
          ),
        )
        @assign l_if__branch__str = lm_66(l_if__branch__str, i_if__branch, a_options)
        @assign l_if__branch__str = Tpl.popIter(l_if__branch__str)
        @assign l_elseif__str = dumpElseIfEEquation(
          Tpl.emptyTxt,
          i_elseif__conds,
          i_elseif__branches,
          a_options,
        )
        @assign l_else__str = fun_68(Tpl.emptyTxt, i_elseBranch, a_options)
        @assign txt = Tpl.writeTok(txt, Tpl.ST_STRING("if "))
        @assign txt = Tpl.writeText(txt, l_if__cond__str)
        @assign txt = Tpl.writeTok(txt, Tpl.ST_LINE(" then\\n"))
        @assign txt = Tpl.pushBlock(txt, Tpl.BT_INDENT(2))
        @assign txt = Tpl.writeText(txt, l_if__branch__str)
        @assign txt = Tpl.softNewLine(txt)
        @assign txt = Tpl.popBlock(txt)
        @assign txt = Tpl.writeText(txt, l_elseif__str)
        @assign txt = Tpl.softNewLine(txt)
        @assign txt = Tpl.writeText(txt, l_else__str)
        @assign txt = Tpl.softNewLine(txt)
        @assign txt = Tpl.writeTok(txt, Tpl.ST_STRING("end if;"))
        txt
      end

      (txt, _, _) => begin
        txt
      end
    end
  end
  return out_txt
end

function lm_70(
  in_txt::Tpl.Text,
  in_items::List{<:SCode.EEquation},
  in_a_options::SCodeDump.SCodeDumpOptions,
)::Tpl.Text
  local out_txt::Tpl.Text

  @assign out_txt = begin
    local txt::Tpl.Text
    local rest::List{SCode.EEquation}
    local a_options::SCodeDump.SCodeDumpOptions
    local i_e::SCode.EEquation
    @match (in_txt, in_items, in_a_options) begin
      (txt, nil(), _) => begin
        txt
      end

      (txt, i_e <| rest, a_options) => begin
        @assign txt = dumpEEquation(txt, i_e, a_options)
        @assign txt = Tpl.nextIter(txt)
        @assign txt = lm_70(txt, rest, a_options)
        txt
      end
    end
  end
  return out_txt
end

function fun_71(
  in_txt::Tpl.Text,
  in_a_branches::List{<:List{<:SCode.EEquation}},
  in_a_rest__conds::List{<:Absyn.Exp},
  in_a_options::SCodeDump.SCodeDumpOptions,
  in_a_cond::Absyn.Exp,
)::Tpl.Text
  local out_txt::Tpl.Text

  @assign out_txt = begin
    local txt::Tpl.Text
    local a_rest__conds::List{Absyn.Exp}
    local a_options::SCodeDump.SCodeDumpOptions
    local a_cond::Absyn.Exp
    local i_rest__branches::List{List{SCode.EEquation}}
    local i_branch::List{SCode.EEquation}
    local l_rest__str::Tpl.Text
    local l_branch__str::Tpl.Text
    local l_cond__str::Tpl.Text
    @match (in_txt, in_a_branches, in_a_rest__conds, in_a_options, in_a_cond) begin
      (txt, i_branch <| i_rest__branches, a_rest__conds, a_options, a_cond) => begin
        @assign l_cond__str = AbsynDumpTpl.dumpExp(Tpl.emptyTxt, a_cond)
        @assign l_branch__str = Tpl.pushIter(
          Tpl.emptyTxt,
          Tpl.ITER_OPTIONS(
            0,
            NONE(),
            SOME(Tpl.ST_NEW_LINE()),
            0,
            0,
            Tpl.ST_NEW_LINE(),
            0,
            Tpl.ST_NEW_LINE(),
          ),
        )
        @assign l_branch__str = lm_70(l_branch__str, i_branch, a_options)
        @assign l_branch__str = Tpl.popIter(l_branch__str)
        @assign l_rest__str =
          dumpElseIfEEquation(Tpl.emptyTxt, a_rest__conds, i_rest__branches, a_options)
        @assign txt = Tpl.writeTok(txt, Tpl.ST_STRING("elseif "))
        @assign txt = Tpl.writeText(txt, l_cond__str)
        @assign txt = Tpl.writeTok(txt, Tpl.ST_LINE(" then\\n"))
        @assign txt = Tpl.pushBlock(txt, Tpl.BT_INDENT(2))
        @assign txt = Tpl.writeText(txt, l_branch__str)
        @assign txt = Tpl.softNewLine(txt)
        @assign txt = Tpl.popBlock(txt)
        @assign txt = Tpl.writeText(txt, l_rest__str)
        txt
      end

      (txt, _, _, _, _) => begin
        txt
      end
    end
  end
  return out_txt
end

function dumpElseIfEEquation(
  in_txt::Tpl.Text,
  in_a_condition::List{<:Absyn.Exp},
  in_a_branches::List{<:List{<:SCode.EEquation}},
  in_a_options::SCodeDump.SCodeDumpOptions,
)::Tpl.Text
  local out_txt::Tpl.Text

  @assign out_txt = begin
    local txt::Tpl.Text
    local a_branches::List{List{SCode.EEquation}}
    local a_options::SCodeDump.SCodeDumpOptions
    local i_rest__conds::List{Absyn.Exp}
    local i_cond::Absyn.Exp
    @match (in_txt, in_a_condition, in_a_branches, in_a_options) begin
      (txt, i_cond <| i_rest__conds, a_branches, a_options) => begin
        @assign txt = fun_71(txt, a_branches, i_rest__conds, a_options, i_cond)
        txt
      end

      (txt, _, _, _) => begin
        txt
      end
    end
  end
  return out_txt
end

function lm_73(
  in_txt::Tpl.Text,
  in_items::List{<:SCode.EEquation},
  in_a_options::SCodeDump.SCodeDumpOptions,
)::Tpl.Text
  local out_txt::Tpl.Text

  @assign out_txt = begin
    local txt::Tpl.Text
    local rest::List{SCode.EEquation}
    local a_options::SCodeDump.SCodeDumpOptions
    local i_e::SCode.EEquation
    @match (in_txt, in_items, in_a_options) begin
      (txt, nil(), _) => begin
        txt
      end

      (txt, i_e <| rest, a_options) => begin
        @assign txt = dumpEEquation(txt, i_e, a_options)
        @assign txt = Tpl.nextIter(txt)
        @assign txt = lm_73(txt, rest, a_options)
        txt
      end
    end
  end
  return out_txt
end

function lm_74(
  in_txt::Tpl.Text,
  in_items::List{<:SCode.EEquation},
  in_a_options::SCodeDump.SCodeDumpOptions,
)::Tpl.Text
  local out_txt::Tpl.Text

  @assign out_txt = begin
    local txt::Tpl.Text
    local rest::List{SCode.EEquation}
    local a_options::SCodeDump.SCodeDumpOptions
    local i_e::SCode.EEquation
    @match (in_txt, in_items, in_a_options) begin
      (txt, nil(), _) => begin
        txt
      end

      (txt, i_e <| rest, a_options) => begin
        @assign txt = dumpEEquation(txt, i_e, a_options)
        @assign txt = Tpl.nextIter(txt)
        @assign txt = lm_74(txt, rest, a_options)
        txt
      end
    end
  end
  return out_txt
end

function dumpForEEquation(
  in_txt::Tpl.Text,
  in_a_for__equation::SCode.EEquation,
  in_a_options::SCodeDump.SCodeDumpOptions,
)::Tpl.Text
  local out_txt::Tpl.Text

  @assign out_txt = begin
    local txt::Tpl.Text
    local a_options::SCodeDump.SCodeDumpOptions
    local i_index::SCode.Ident
    local i_comment::SCode.Comment
    local i_eEquationLst::List{SCode.EEquation}
    local i_range::Absyn.Exp
    local l_cmt__str::Tpl.Text
    local l_eq__str::Tpl.Text
    local l_range__str::Tpl.Text
    @match (in_txt, in_a_for__equation, in_a_options) begin
      (
        txt,
        SCode.EQ_FOR(
          range = SOME(i_range),
          eEquationLst = i_eEquationLst,
          comment = i_comment,
          index = i_index,
        ),
        a_options,
      ) => begin
        @assign l_range__str = AbsynDumpTpl.dumpExp(Tpl.emptyTxt, i_range)
        @assign l_eq__str = Tpl.pushIter(
          Tpl.emptyTxt,
          Tpl.ITER_OPTIONS(
            0,
            NONE(),
            SOME(Tpl.ST_NEW_LINE()),
            0,
            0,
            Tpl.ST_NEW_LINE(),
            0,
            Tpl.ST_NEW_LINE(),
          ),
        )
        @assign l_eq__str = lm_73(l_eq__str, i_eEquationLst, a_options)
        @assign l_eq__str = Tpl.popIter(l_eq__str)
        @assign l_cmt__str = dumpComment(Tpl.emptyTxt, i_comment, a_options)
        @assign txt = Tpl.writeTok(txt, Tpl.ST_STRING("for "))
        @assign txt = Tpl.writeStr(txt, i_index)
        @assign txt = Tpl.writeTok(txt, Tpl.ST_STRING(" in "))
        @assign txt = Tpl.writeText(txt, l_range__str)
        @assign txt = Tpl.writeTok(txt, Tpl.ST_LINE(" loop\\n"))
        @assign txt = Tpl.pushBlock(txt, Tpl.BT_INDENT(2))
        @assign txt = Tpl.writeText(txt, l_eq__str)
        @assign txt = Tpl.softNewLine(txt)
        @assign txt = Tpl.popBlock(txt)
        @assign txt = Tpl.writeTok(txt, Tpl.ST_STRING("end for"))
        @assign txt = Tpl.writeText(txt, l_cmt__str)
        @assign txt = Tpl.writeTok(txt, Tpl.ST_STRING(";"))
        txt
      end

      (
        txt,
        SCode.EQ_FOR(eEquationLst = i_eEquationLst, comment = i_comment, index = i_index),
        a_options,
      ) => begin
        @assign l_eq__str = Tpl.pushIter(
          Tpl.emptyTxt,
          Tpl.ITER_OPTIONS(
            0,
            NONE(),
            SOME(Tpl.ST_NEW_LINE()),
            0,
            0,
            Tpl.ST_NEW_LINE(),
            0,
            Tpl.ST_NEW_LINE(),
          ),
        )
        @assign l_eq__str = lm_74(l_eq__str, i_eEquationLst, a_options)
        @assign l_eq__str = Tpl.popIter(l_eq__str)
        @assign l_cmt__str = dumpComment(Tpl.emptyTxt, i_comment, a_options)
        @assign txt = Tpl.writeTok(txt, Tpl.ST_STRING("for "))
        @assign txt = Tpl.writeStr(txt, i_index)
        @assign txt = Tpl.writeTok(txt, Tpl.ST_LINE(" loop\\n"))
        @assign txt = Tpl.pushBlock(txt, Tpl.BT_INDENT(2))
        @assign txt = Tpl.writeText(txt, l_eq__str)
        @assign txt = Tpl.softNewLine(txt)
        @assign txt = Tpl.popBlock(txt)
        @assign txt = Tpl.writeTok(txt, Tpl.ST_STRING("end for"))
        @assign txt = Tpl.writeText(txt, l_cmt__str)
        @assign txt = Tpl.writeTok(txt, Tpl.ST_STRING(";"))
        txt
      end

      (txt, _, _) => begin
        txt
      end
    end
  end
  return out_txt
end

function lm_76(
  in_txt::Tpl.Text,
  in_items::List{<:SCode.EEquation},
  in_a_options::SCodeDump.SCodeDumpOptions,
)::Tpl.Text
  local out_txt::Tpl.Text

  @assign out_txt = begin
    local txt::Tpl.Text
    local rest::List{SCode.EEquation}
    local a_options::SCodeDump.SCodeDumpOptions
    local i_e::SCode.EEquation
    @match (in_txt, in_items, in_a_options) begin
      (txt, nil(), _) => begin
        txt
      end

      (txt, i_e <| rest, a_options) => begin
        @assign txt = dumpEEquation(txt, i_e, a_options)
        @assign txt = Tpl.nextIter(txt)
        @assign txt = lm_76(txt, rest, a_options)
        txt
      end
    end
  end
  return out_txt
end

function lm_77(
  in_txt::Tpl.Text,
  in_items::List{<:SCode.EEquation},
  in_a_options::SCodeDump.SCodeDumpOptions,
)::Tpl.Text
  local out_txt::Tpl.Text

  @assign out_txt = begin
    local txt::Tpl.Text
    local rest::List{SCode.EEquation}
    local a_options::SCodeDump.SCodeDumpOptions
    local i_e::SCode.EEquation
    @match (in_txt, in_items, in_a_options) begin
      (txt, nil(), _) => begin
        txt
      end

      (txt, i_e <| rest, a_options) => begin
        @assign txt = dumpEEquation(txt, i_e, a_options)
        @assign txt = Tpl.nextIter(txt)
        @assign txt = lm_77(txt, rest, a_options)
        txt
      end
    end
  end
  return out_txt
end

function lm_78(
  in_txt::Tpl.Text,
  in_items::List{<:Tuple{<:Absyn.Exp, List{<:SCode.EEquation}}},
  in_a_options::SCodeDump.SCodeDumpOptions,
)::Tpl.Text
  local out_txt::Tpl.Text

  @assign out_txt = begin
    local txt::Tpl.Text
    local rest::List{Tuple{Absyn.Exp, List{SCode.EEquation}}}
    local a_options::SCodeDump.SCodeDumpOptions
    local i_else__body::List{SCode.EEquation}
    local i_else__cond::Absyn.Exp
    local l_else__body__str::Tpl.Text
    local l_else__cond__str::Tpl.Text
    @match (in_txt, in_items, in_a_options) begin
      (txt, nil(), _) => begin
        txt
      end

      (txt, (i_else__cond, i_else__body) <| rest, a_options) => begin
        @assign l_else__cond__str = AbsynDumpTpl.dumpExp(Tpl.emptyTxt, i_else__cond)
        @assign l_else__body__str = Tpl.pushIter(
          Tpl.emptyTxt,
          Tpl.ITER_OPTIONS(
            0,
            NONE(),
            SOME(Tpl.ST_NEW_LINE()),
            0,
            0,
            Tpl.ST_NEW_LINE(),
            0,
            Tpl.ST_NEW_LINE(),
          ),
        )
        @assign l_else__body__str = lm_77(l_else__body__str, i_else__body, a_options)
        @assign l_else__body__str = Tpl.popIter(l_else__body__str)
        @assign txt = Tpl.writeTok(txt, Tpl.ST_STRING("elsewhen "))
        @assign txt = Tpl.writeText(txt, l_else__cond__str)
        @assign txt = Tpl.writeTok(txt, Tpl.ST_LINE(" then\\n"))
        @assign txt = Tpl.pushBlock(txt, Tpl.BT_INDENT(2))
        @assign txt = Tpl.writeText(txt, l_else__body__str)
        @assign txt = Tpl.popBlock(txt)
        @assign txt = Tpl.nextIter(txt)
        @assign txt = lm_78(txt, rest, a_options)
        txt
      end
    end
  end
  return out_txt
end

function dumpWhenEEquation(
  in_txt::Tpl.Text,
  in_a_when__equation::SCode.EEquation,
  in_a_options::SCodeDump.SCodeDumpOptions,
)::Tpl.Text
  local out_txt::Tpl.Text

  @assign out_txt = begin
    local txt::Tpl.Text
    local a_options::SCodeDump.SCodeDumpOptions
    local i_comment::SCode.Comment
    local i_elseBranches::List{Tuple{Absyn.Exp, List{SCode.EEquation}}}
    local i_eEquationLst::List{SCode.EEquation}
    local i_condition::Absyn.Exp
    local l_cmt__str::Tpl.Text
    local l_else__str::Tpl.Text
    local l_body__str::Tpl.Text
    local l_cond__str::Tpl.Text
    @match (in_txt, in_a_when__equation, in_a_options) begin
      (
        txt,
        SCode.EQ_WHEN(
          condition = i_condition,
          eEquationLst = i_eEquationLst,
          elseBranches = i_elseBranches,
          comment = i_comment,
        ),
        a_options,
      ) => begin
        @assign l_cond__str = AbsynDumpTpl.dumpExp(Tpl.emptyTxt, i_condition)
        @assign l_body__str = Tpl.pushIter(
          Tpl.emptyTxt,
          Tpl.ITER_OPTIONS(
            0,
            NONE(),
            SOME(Tpl.ST_NEW_LINE()),
            0,
            0,
            Tpl.ST_NEW_LINE(),
            0,
            Tpl.ST_NEW_LINE(),
          ),
        )
        @assign l_body__str = lm_76(l_body__str, i_eEquationLst, a_options)
        @assign l_body__str = Tpl.popIter(l_body__str)
        @assign l_else__str = Tpl.pushIter(
          Tpl.emptyTxt,
          Tpl.ITER_OPTIONS(
            0,
            NONE(),
            SOME(Tpl.ST_NEW_LINE()),
            0,
            0,
            Tpl.ST_NEW_LINE(),
            0,
            Tpl.ST_NEW_LINE(),
          ),
        )
        @assign l_else__str = lm_78(l_else__str, i_elseBranches, a_options)
        @assign l_else__str = Tpl.popIter(l_else__str)
        @assign l_cmt__str = dumpComment(Tpl.emptyTxt, i_comment, a_options)
        @assign txt = Tpl.writeTok(txt, Tpl.ST_STRING("when "))
        @assign txt = Tpl.writeText(txt, l_cond__str)
        @assign txt = Tpl.writeTok(txt, Tpl.ST_STRING(" then"))
        @assign txt = Tpl.writeText(txt, l_cmt__str)
        @assign txt = Tpl.softNewLine(txt)
        @assign txt = Tpl.pushBlock(txt, Tpl.BT_INDENT(2))
        @assign txt = Tpl.writeText(txt, l_body__str)
        @assign txt = Tpl.softNewLine(txt)
        @assign txt = Tpl.popBlock(txt)
        @assign txt = Tpl.writeText(txt, l_else__str)
        @assign txt = Tpl.softNewLine(txt)
        @assign txt = Tpl.writeTok(txt, Tpl.ST_STRING("end when;"))
        txt
      end

      (txt, _, _) => begin
        txt
      end
    end
  end
  return out_txt
end

function dumpAssertionLevel(in_txt::Tpl.Text, in_a_exp::Absyn.Exp)::Tpl.Text
  local out_txt::Tpl.Text

  @assign out_txt = begin
    local txt::Tpl.Text
    local i_exp::Absyn.Exp
    @match (in_txt, in_a_exp) begin
      (
        txt,
        Absyn.CREF(
          componentRef = Absyn.CREF_FULLYQUALIFIED(
            componentRef = Absyn.CREF_QUAL(
              name = "AssertionLevel",
              componentRef = Absyn.CREF_IDENT(name = "error"),
            ),
          ),
        ),
      ) => begin
        txt
      end

      (
        txt,
        Absyn.CREF(
          componentRef = Absyn.CREF_QUAL(
            name = "AssertionLevel",
            componentRef = Absyn.CREF_IDENT(name = "error"),
          ),
        ),
      ) => begin
        txt
      end

      (txt, i_exp) => begin
        @assign txt = Tpl.writeTok(txt, Tpl.ST_STRING(", "))
        @assign txt = AbsynDumpTpl.dumpExp(txt, i_exp)
        txt
      end
    end
  end
  return out_txt
end

function lm_81(
  in_txt::Tpl.Text,
  in_items::List{<:SCode.AlgorithmSection},
  in_a_options::SCodeDump.SCodeDumpOptions,
)::Tpl.Text
  local out_txt::Tpl.Text

  @assign out_txt = begin
    local txt::Tpl.Text
    local rest::List{SCode.AlgorithmSection}
    local a_options::SCodeDump.SCodeDumpOptions
    local i_al::SCode.AlgorithmSection
    @match (in_txt, in_items, in_a_options) begin
      (txt, nil(), _) => begin
        txt
      end

      (txt, i_al <| rest, a_options) => begin
        @assign txt = dumpAlgorithmSection(txt, i_al, a_options)
        @assign txt = Tpl.nextIter(txt)
        @assign txt = lm_81(txt, rest, a_options)
        txt
      end
    end
  end
  return out_txt
end

function dumpAlgorithmSections(
  in_txt::Tpl.Text,
  in_a_algorithms::List{<:SCode.AlgorithmSection},
  in_a_label::String,
  in_a_options::SCodeDump.SCodeDumpOptions,
)::Tpl.Text
  local out_txt::Tpl.Text

  @assign out_txt = begin
    local txt::Tpl.Text
    local a_label::String
    local a_options::SCodeDump.SCodeDumpOptions
    local i_algorithms::List{SCode.AlgorithmSection}
    @match (in_txt, in_a_algorithms, in_a_label, in_a_options) begin
      (txt, nil(), _, _) => begin
        txt
      end

      (txt, i_algorithms, a_label, a_options) => begin
        @assign txt = Tpl.writeStr(txt, a_label)
        @assign txt = Tpl.softNewLine(txt)
        @assign txt = Tpl.pushBlock(txt, Tpl.BT_INDENT(2))
        @assign txt = Tpl.pushIter(
          txt,
          Tpl.ITER_OPTIONS(
            0,
            NONE(),
            SOME(Tpl.ST_NEW_LINE()),
            0,
            0,
            Tpl.ST_NEW_LINE(),
            0,
            Tpl.ST_NEW_LINE(),
          ),
        )
        @assign txt = lm_81(txt, i_algorithms, a_options)
        @assign txt = Tpl.popIter(txt)
        @assign txt = Tpl.popBlock(txt)
        txt
      end
    end
  end
  return out_txt
end

function dumpAlgorithmSection(
  in_txt::Tpl.Text,
  in_a_algorithm::SCode.AlgorithmSection,
  in_a_options::SCodeDump.SCodeDumpOptions,
)::Tpl.Text
  local out_txt::Tpl.Text

  @assign out_txt = begin
    local txt::Tpl.Text
    local a_options::SCodeDump.SCodeDumpOptions
    local i_statements::List{SCode.Statement}
    @match (in_txt, in_a_algorithm, in_a_options) begin
      (txt, SCode.ALGORITHM(statements = i_statements), a_options) => begin
        @assign txt = dumpStatements(txt, i_statements, a_options)
        txt
      end

      (txt, _, _) => begin
        txt
      end
    end
  end
  return out_txt
end

function lm_84(
  in_txt::Tpl.Text,
  in_items::List{<:SCode.Statement},
  in_a_options::SCodeDump.SCodeDumpOptions,
)::Tpl.Text
  local out_txt::Tpl.Text

  @assign out_txt = begin
    local txt::Tpl.Text
    local rest::List{SCode.Statement}
    local a_options::SCodeDump.SCodeDumpOptions
    local i_s::SCode.Statement
    @match (in_txt, in_items, in_a_options) begin
      (txt, nil(), _) => begin
        txt
      end

      (txt, i_s <| rest, a_options) => begin
        @assign txt = dumpStatement(txt, i_s, a_options)
        @assign txt = Tpl.nextIter(txt)
        @assign txt = lm_84(txt, rest, a_options)
        txt
      end
    end
  end
  return out_txt
end

function dumpStatements(
  txt::Tpl.Text,
  a_statements::List{<:SCode.Statement},
  a_options::SCodeDump.SCodeDumpOptions,
)::Tpl.Text
  local out_txt::Tpl.Text

  @assign out_txt = Tpl.pushIter(
    txt,
    Tpl.ITER_OPTIONS(
      0,
      NONE(),
      SOME(Tpl.ST_NEW_LINE()),
      0,
      0,
      Tpl.ST_NEW_LINE(),
      0,
      Tpl.ST_NEW_LINE(),
    ),
  )
  @assign out_txt = lm_84(out_txt, a_statements, a_options)
  @assign out_txt = Tpl.popIter(out_txt)
  return out_txt
end

function dumpStatement(
  in_txt::Tpl.Text,
  in_a_statement::SCode.Statement,
  in_a_options::SCodeDump.SCodeDumpOptions,
)::Tpl.Text
  local out_txt::Tpl.Text

  @assign out_txt = begin
    local txt::Tpl.Text
    local a_options::SCodeDump.SCodeDumpOptions
    local i_stmt::SCode.Statement
    local i_exp::Absyn.Exp
    local i_newValue::Absyn.Exp
    local i_cref::Absyn.Exp
    local i_level::Absyn.Exp
    local i_message::Absyn.Exp
    local i_condition::Absyn.Exp
    local i_statement::SCode.Statement
    local i_comment::SCode.Comment
    local i_value::Absyn.Exp
    local i_assignComponent::Absyn.Exp
    local l_exp__str::Tpl.Text
    local l_cr__str::Tpl.Text
    local l_lvl__str::Tpl.Text
    local l_msg__str::Tpl.Text
    local l_cond__str::Tpl.Text
    local l_cmt__str::Tpl.Text
    local l_rhs__str::Tpl.Text
    local l_lhs__str::Tpl.Text
    @match (in_txt, in_a_statement, in_a_options) begin
      (
        txt,
        SCode.ALG_ASSIGN(
          assignComponent = i_assignComponent,
          value = i_value,
          comment = i_comment,
        ),
        a_options,
      ) => begin
        @assign l_lhs__str = AbsynDumpTpl.dumpLhsExp(Tpl.emptyTxt, i_assignComponent)
        @assign l_rhs__str = AbsynDumpTpl.dumpExp(Tpl.emptyTxt, i_value)
        @assign l_cmt__str = dumpComment(Tpl.emptyTxt, i_comment, a_options)
        @assign txt = Tpl.writeText(txt, l_lhs__str)
        @assign txt = Tpl.writeTok(txt, Tpl.ST_STRING(" := "))
        @assign txt = Tpl.writeText(txt, l_rhs__str)
        @assign txt = Tpl.writeText(txt, l_cmt__str)
        @assign txt = Tpl.writeTok(txt, Tpl.ST_STRING(";"))
        txt
      end

      (txt, i_statement && SCode.ALG_IF(boolExpr = _), a_options) => begin
        @assign txt = dumpIfStatement(txt, i_statement, a_options)
        txt
      end

      (txt, i_statement && SCode.ALG_FOR(index = _), a_options) => begin
        @assign txt = dumpForStatement(txt, i_statement, a_options)
        txt
      end

      (txt, i_statement && SCode.ALG_WHILE(boolExpr = _), a_options) => begin
        @assign txt = dumpWhileStatement(txt, i_statement, a_options)
        txt
      end

      (txt, i_statement && SCode.ALG_WHEN_A(branches = _), a_options) => begin
        @assign txt = dumpWhenStatement(txt, i_statement, a_options)
        txt
      end

      (
        txt,
        SCode.ALG_ASSERT(condition = i_condition, message = i_message, level = i_level),
        _,
      ) => begin
        @assign l_cond__str = AbsynDumpTpl.dumpExp(Tpl.emptyTxt, i_condition)
        @assign l_msg__str = AbsynDumpTpl.dumpExp(Tpl.emptyTxt, i_message)
        @assign l_lvl__str = dumpAssertionLevel(Tpl.emptyTxt, i_level)
        @assign txt = Tpl.writeTok(txt, Tpl.ST_STRING("assert("))
        @assign txt = Tpl.writeText(txt, l_cond__str)
        @assign txt = Tpl.writeTok(txt, Tpl.ST_STRING(", "))
        @assign txt = Tpl.writeText(txt, l_msg__str)
        @assign txt = Tpl.writeText(txt, l_lvl__str)
        @assign txt = Tpl.writeTok(txt, Tpl.ST_STRING(");"))
        txt
      end

      (txt, SCode.ALG_TERMINATE(message = i_message), _) => begin
        @assign l_msg__str = AbsynDumpTpl.dumpExp(Tpl.emptyTxt, i_message)
        @assign txt = Tpl.writeTok(txt, Tpl.ST_STRING("terminate("))
        @assign txt = Tpl.writeText(txt, l_msg__str)
        @assign txt = Tpl.writeTok(txt, Tpl.ST_STRING(");"))
        txt
      end

      (txt, SCode.ALG_REINIT(cref = i_cref, newValue = i_newValue), _) => begin
        @assign l_cr__str = AbsynDumpTpl.dumpExp(Tpl.emptyTxt, i_cref)
        @assign l_exp__str = AbsynDumpTpl.dumpExp(Tpl.emptyTxt, i_newValue)
        @assign txt = Tpl.writeTok(txt, Tpl.ST_STRING("reinit("))
        @assign txt = Tpl.writeText(txt, l_cr__str)
        @assign txt = Tpl.writeTok(txt, Tpl.ST_STRING(", "))
        @assign txt = Tpl.writeText(txt, l_exp__str)
        @assign txt = Tpl.writeTok(txt, Tpl.ST_STRING(");"))
        txt
      end

      (txt, SCode.ALG_NORETCALL(exp = i_exp, comment = i_comment), a_options) => begin
        @assign l_exp__str = AbsynDumpTpl.dumpExp(Tpl.emptyTxt, i_exp)
        @assign l_cmt__str = dumpComment(Tpl.emptyTxt, i_comment, a_options)
        @assign txt = Tpl.writeText(txt, l_exp__str)
        @assign txt = Tpl.writeText(txt, l_cmt__str)
        @assign txt = Tpl.writeTok(txt, Tpl.ST_STRING(";"))
        txt
      end

      (txt, SCode.ALG_RETURN(comment = i_comment), a_options) => begin
        @assign l_cmt__str = dumpComment(Tpl.emptyTxt, i_comment, a_options)
        @assign txt = Tpl.writeTok(txt, Tpl.ST_STRING("return"))
        @assign txt = Tpl.writeText(txt, l_cmt__str)
        @assign txt = Tpl.writeTok(txt, Tpl.ST_STRING(";"))
        txt
      end

      (txt, SCode.ALG_BREAK(comment = i_comment), a_options) => begin
        @assign l_cmt__str = dumpComment(Tpl.emptyTxt, i_comment, a_options)
        @assign txt = Tpl.writeTok(txt, Tpl.ST_STRING("break"))
        @assign txt = Tpl.writeText(txt, l_cmt__str)
        @assign txt = Tpl.writeTok(txt, Tpl.ST_STRING(";"))
        txt
      end

      (txt, SCode.ALG_FAILURE(stmts = i_stmt <| nil(), comment = i_comment), a_options) =>
        begin
          @assign l_cmt__str = dumpComment(Tpl.emptyTxt, i_comment, a_options)
          @assign txt = Tpl.writeTok(txt, Tpl.ST_STRING("failure("))
          @assign txt = dumpStatement(txt, i_stmt, a_options)
          @assign txt = Tpl.writeTok(txt, Tpl.ST_STRING(")"))
          @assign txt = Tpl.writeText(txt, l_cmt__str)
          @assign txt = Tpl.writeTok(txt, Tpl.ST_STRING(";"))
          txt
        end

      (txt, i_statement && SCode.ALG_TRY(body = _), a_options) => begin
        @assign txt = dumpTryStatement(txt, i_statement, a_options)
        txt
      end

      (txt, SCode.ALG_CONTINUE(comment = i_comment), a_options) => begin
        @assign l_cmt__str = dumpComment(Tpl.emptyTxt, i_comment, a_options)
        @assign txt = Tpl.writeTok(txt, Tpl.ST_STRING("continue"))
        @assign txt = Tpl.writeText(txt, l_cmt__str)
        @assign txt = Tpl.writeTok(txt, Tpl.ST_STRING(";"))
        txt
      end

      (txt, _, _) => begin
        @assign txt = errorMsg(txt, "SCodeDump.dumpStatement: Unknown statement.")
        txt
      end
    end
  end
  return out_txt
end

function dumpIfStatement(
  in_txt::Tpl.Text,
  in_a_if__statement::SCode.Statement,
  in_a_options::SCodeDump.SCodeDumpOptions,
)::Tpl.Text
  local out_txt::Tpl.Text

  @assign out_txt = begin
    local txt::Tpl.Text
    local a_options::SCodeDump.SCodeDumpOptions
    local i_comment::SCode.Comment
    local i_elseBranch::List{SCode.Statement}
    local i_elseIfBranch::List{Tuple{Absyn.Exp, List{SCode.Statement}}}
    local i_trueBranch::List{SCode.Statement}
    local i_boolExpr::Absyn.Exp
    local l_cmt__str::Tpl.Text
    local l_else__branch__str::Tpl.Text
    local l_else__if__str::Tpl.Text
    local l_true__branch__str::Tpl.Text
    local l_cond__str::Tpl.Text
    @match (in_txt, in_a_if__statement, in_a_options) begin
      (
        txt,
        SCode.ALG_IF(
          boolExpr = i_boolExpr,
          trueBranch = i_trueBranch,
          elseIfBranch = i_elseIfBranch,
          elseBranch = i_elseBranch,
          comment = i_comment,
        ),
        a_options,
      ) => begin
        @assign l_cond__str = AbsynDumpTpl.dumpExp(Tpl.emptyTxt, i_boolExpr)
        @assign l_true__branch__str =
          dumpStatements(Tpl.emptyTxt, i_trueBranch, a_options)
        @assign l_else__if__str =
          dumpElseIfStatements(Tpl.emptyTxt, i_elseIfBranch, a_options)
        @assign l_else__branch__str =
          dumpStatements(Tpl.emptyTxt, i_elseBranch, a_options)
        @assign l_cmt__str = dumpComment(Tpl.emptyTxt, i_comment, a_options)
        @assign txt = Tpl.writeTok(txt, Tpl.ST_STRING("if "))
        @assign txt = Tpl.writeText(txt, l_cond__str)
        @assign txt = Tpl.writeTok(txt, Tpl.ST_STRING(" then"))
        @assign txt = Tpl.writeText(txt, l_cmt__str)
        @assign txt = Tpl.softNewLine(txt)
        @assign txt = Tpl.pushBlock(txt, Tpl.BT_INDENT(2))
        @assign txt = Tpl.writeText(txt, l_true__branch__str)
        @assign txt = Tpl.softNewLine(txt)
        @assign txt = Tpl.popBlock(txt)
        @assign txt = Tpl.writeText(txt, l_else__if__str)
        @assign txt = Tpl.softNewLine(txt)
        @assign txt = Tpl.writeTok(txt, Tpl.ST_LINE("else\\n"))
        @assign txt = Tpl.pushBlock(txt, Tpl.BT_INDENT(2))
        @assign txt = Tpl.writeText(txt, l_else__branch__str)
        @assign txt = Tpl.softNewLine(txt)
        @assign txt = Tpl.popBlock(txt)
        @assign txt = Tpl.writeTok(txt, Tpl.ST_STRING("end if;"))
        txt
      end

      (txt, _, _) => begin
        txt
      end
    end
  end
  return out_txt
end

function lm_88(
  in_txt::Tpl.Text,
  in_items::List{<:Tuple{<:Absyn.Exp, List{<:SCode.Statement}}},
  in_a_options::SCodeDump.SCodeDumpOptions,
)::Tpl.Text
  local out_txt::Tpl.Text

  @assign out_txt = begin
    local txt::Tpl.Text
    local rest::List{Tuple{Absyn.Exp, List{SCode.Statement}}}
    local a_options::SCodeDump.SCodeDumpOptions
    local i_body::List{SCode.Statement}
    local i_cond::Absyn.Exp
    local l_body__str::Tpl.Text
    local l_cond__str::Tpl.Text
    @match (in_txt, in_items, in_a_options) begin
      (txt, nil(), _) => begin
        txt
      end

      (txt, (i_cond, i_body) <| rest, a_options) => begin
        @assign l_cond__str = AbsynDumpTpl.dumpExp(Tpl.emptyTxt, i_cond)
        @assign l_body__str = dumpStatements(Tpl.emptyTxt, i_body, a_options)
        @assign txt = Tpl.writeTok(txt, Tpl.ST_STRING("elseif "))
        @assign txt = Tpl.writeText(txt, l_cond__str)
        @assign txt = Tpl.writeTok(txt, Tpl.ST_LINE(" then\\n"))
        @assign txt = Tpl.pushBlock(txt, Tpl.BT_INDENT(2))
        @assign txt = Tpl.writeText(txt, l_body__str)
        @assign txt = Tpl.popBlock(txt)
        @assign txt = Tpl.nextIter(txt)
        @assign txt = lm_88(txt, rest, a_options)
        txt
      end
    end
  end
  return out_txt
end

function dumpElseIfStatements(
  txt::Tpl.Text,
  a_else__if::List{<:Tuple{<:Absyn.Exp, List{<:SCode.Statement}}},
  a_options::SCodeDump.SCodeDumpOptions,
)::Tpl.Text
  local out_txt::Tpl.Text

  @assign out_txt = Tpl.pushIter(
    txt,
    Tpl.ITER_OPTIONS(
      0,
      NONE(),
      SOME(Tpl.ST_NEW_LINE()),
      0,
      0,
      Tpl.ST_NEW_LINE(),
      0,
      Tpl.ST_NEW_LINE(),
    ),
  )
  @assign out_txt = lm_88(out_txt, a_else__if, a_options)
  @assign out_txt = Tpl.popIter(out_txt)
  return out_txt
end

function dumpForStatement(
  in_txt::Tpl.Text,
  in_a_for__statement::SCode.Statement,
  in_a_options::SCodeDump.SCodeDumpOptions,
)::Tpl.Text
  local out_txt::Tpl.Text

  @assign out_txt = begin
    local txt::Tpl.Text
    local a_options::SCodeDump.SCodeDumpOptions
    local i_index::String
    local i_comment::SCode.Comment
    local i_forBody::List{SCode.Statement}
    local i_e::Absyn.Exp
    local l_cmt__str::Tpl.Text
    local l_body__str::Tpl.Text
    local l_range__str::Tpl.Text
    @match (in_txt, in_a_for__statement, in_a_options) begin
      (
        txt,
        SCode.ALG_FOR(
          range = SOME(i_e),
          forBody = i_forBody,
          comment = i_comment,
          index = i_index,
        ),
        a_options,
      ) => begin
        @assign l_range__str = AbsynDumpTpl.dumpExp(Tpl.emptyTxt, i_e)
        @assign l_body__str = dumpStatements(Tpl.emptyTxt, i_forBody, a_options)
        @assign l_cmt__str = dumpComment(Tpl.emptyTxt, i_comment, a_options)
        @assign txt = Tpl.writeTok(txt, Tpl.ST_STRING("for "))
        @assign txt = Tpl.writeStr(txt, i_index)
        @assign txt = Tpl.writeTok(txt, Tpl.ST_STRING(" in "))
        @assign txt = Tpl.writeText(txt, l_range__str)
        @assign txt = Tpl.writeTok(txt, Tpl.ST_LINE(" loop\\n"))
        @assign txt = Tpl.pushBlock(txt, Tpl.BT_INDENT(2))
        @assign txt = Tpl.writeText(txt, l_body__str)
        @assign txt = Tpl.softNewLine(txt)
        @assign txt = Tpl.popBlock(txt)
        @assign txt = Tpl.writeTok(txt, Tpl.ST_STRING("end for"))
        @assign txt = Tpl.writeText(txt, l_cmt__str)
        @assign txt = Tpl.writeTok(txt, Tpl.ST_STRING(";"))
        txt
      end

      (
        txt,
        SCode.ALG_FOR(forBody = i_forBody, comment = i_comment, index = i_index),
        a_options,
      ) => begin
        @assign l_body__str = dumpStatements(Tpl.emptyTxt, i_forBody, a_options)
        @assign l_cmt__str = dumpComment(Tpl.emptyTxt, i_comment, a_options)
        @assign txt = Tpl.writeTok(txt, Tpl.ST_STRING("for "))
        @assign txt = Tpl.writeStr(txt, i_index)
        @assign txt = Tpl.writeTok(txt, Tpl.ST_LINE(" loop\\n"))
        @assign txt = Tpl.pushBlock(txt, Tpl.BT_INDENT(2))
        @assign txt = Tpl.writeText(txt, l_body__str)
        @assign txt = Tpl.softNewLine(txt)
        @assign txt = Tpl.popBlock(txt)
        @assign txt = Tpl.writeTok(txt, Tpl.ST_STRING("end for"))
        @assign txt = Tpl.writeText(txt, l_cmt__str)
        @assign txt = Tpl.writeTok(txt, Tpl.ST_STRING(";"))
        txt
      end

      (txt, _, _) => begin
        txt
      end
    end
  end
  return out_txt
end

function dumpWhileStatement(
  in_txt::Tpl.Text,
  in_a_while__statement::SCode.Statement,
  in_a_options::SCodeDump.SCodeDumpOptions,
)::Tpl.Text
  local out_txt::Tpl.Text

  @assign out_txt = begin
    local txt::Tpl.Text
    local a_options::SCodeDump.SCodeDumpOptions
    local i_comment::SCode.Comment
    local i_whileBody::List{SCode.Statement}
    local i_boolExpr::Absyn.Exp
    local l_cmt__str::Tpl.Text
    local l_body__str::Tpl.Text
    local l_cond__str::Tpl.Text
    @match (in_txt, in_a_while__statement, in_a_options) begin
      (
        txt,
        SCode.ALG_WHILE(
          boolExpr = i_boolExpr,
          whileBody = i_whileBody,
          comment = i_comment,
        ),
        a_options,
      ) => begin
        @assign l_cond__str = AbsynDumpTpl.dumpExp(Tpl.emptyTxt, i_boolExpr)
        @assign l_body__str = dumpStatements(Tpl.emptyTxt, i_whileBody, a_options)
        @assign l_cmt__str = dumpComment(Tpl.emptyTxt, i_comment, a_options)
        @assign txt = Tpl.writeTok(txt, Tpl.ST_STRING("while "))
        @assign txt = Tpl.writeText(txt, l_cond__str)
        @assign txt = Tpl.writeTok(txt, Tpl.ST_LINE(" loop\\n"))
        @assign txt = Tpl.pushBlock(txt, Tpl.BT_INDENT(2))
        @assign txt = Tpl.writeText(txt, l_body__str)
        @assign txt = Tpl.softNewLine(txt)
        @assign txt = Tpl.popBlock(txt)
        @assign txt = Tpl.writeTok(txt, Tpl.ST_STRING("end while;"))
        txt
      end

      (txt, _, _) => begin
        txt
      end
    end
  end
  return out_txt
end

function lm_92(
  in_txt::Tpl.Text,
  in_items::List{<:Tuple{<:Absyn.Exp, List{<:SCode.Statement}}},
  in_a_options::SCodeDump.SCodeDumpOptions,
)::Tpl.Text
  local out_txt::Tpl.Text

  @assign out_txt = begin
    local txt::Tpl.Text
    local rest::List{Tuple{Absyn.Exp, List{SCode.Statement}}}
    local a_options::SCodeDump.SCodeDumpOptions
    local i_ew__body::List{SCode.Statement}
    local i_ew__cond::Absyn.Exp
    local l_ew__body__str::Tpl.Text
    local l_ew__cond__str::Tpl.Text
    @match (in_txt, in_items, in_a_options) begin
      (txt, nil(), _) => begin
        txt
      end

      (txt, (i_ew__cond, i_ew__body) <| rest, a_options) => begin
        @assign l_ew__cond__str = AbsynDumpTpl.dumpExp(Tpl.emptyTxt, i_ew__cond)
        @assign l_ew__body__str = dumpStatements(Tpl.emptyTxt, i_ew__body, a_options)
        @assign txt = Tpl.writeTok(txt, Tpl.ST_STRING("elsewhen "))
        @assign txt = Tpl.writeText(txt, l_ew__cond__str)
        @assign txt = Tpl.writeTok(txt, Tpl.ST_LINE(" then\\n"))
        @assign txt = Tpl.pushBlock(txt, Tpl.BT_INDENT(2))
        @assign txt = Tpl.writeText(txt, l_ew__body__str)
        @assign txt = Tpl.popBlock(txt)
        @assign txt = Tpl.nextIter(txt)
        @assign txt = lm_92(txt, rest, a_options)
        txt
      end
    end
  end
  return out_txt
end

function dumpWhenStatement(
  in_txt::Tpl.Text,
  in_a_when__statement::SCode.Statement,
  in_a_options::SCodeDump.SCodeDumpOptions,
)::Tpl.Text
  local out_txt::Tpl.Text

  @assign out_txt = begin
    local txt::Tpl.Text
    local a_options::SCodeDump.SCodeDumpOptions
    local i_comment::SCode.Comment
    local i_elsewhens::List{Tuple{Absyn.Exp, List{SCode.Statement}}}
    local i_when__body::List{SCode.Statement}
    local i_when__cond::Absyn.Exp
    local l_cmt__str::Tpl.Text
    local l_elsewhen__str::Tpl.Text
    local l_when__body__str::Tpl.Text
    local l_when__cond__str::Tpl.Text
    @match (in_txt, in_a_when__statement, in_a_options) begin
      (
        txt,
        SCode.ALG_WHEN_A(
          branches = (i_when__cond, i_when__body) <| i_elsewhens,
          comment = i_comment,
        ),
        a_options,
      ) => begin
        @assign l_when__cond__str = AbsynDumpTpl.dumpExp(Tpl.emptyTxt, i_when__cond)
        @assign l_when__body__str = dumpStatements(Tpl.emptyTxt, i_when__body, a_options)
        @assign l_elsewhen__str = Tpl.pushIter(
          Tpl.emptyTxt,
          Tpl.ITER_OPTIONS(
            0,
            NONE(),
            SOME(Tpl.ST_NEW_LINE()),
            0,
            0,
            Tpl.ST_NEW_LINE(),
            0,
            Tpl.ST_NEW_LINE(),
          ),
        )
        @assign l_elsewhen__str = lm_92(l_elsewhen__str, i_elsewhens, a_options)
        @assign l_elsewhen__str = Tpl.popIter(l_elsewhen__str)
        @assign l_cmt__str = dumpComment(Tpl.emptyTxt, i_comment, a_options)
        @assign txt = Tpl.writeTok(txt, Tpl.ST_STRING("when "))
        @assign txt = Tpl.writeText(txt, l_when__cond__str)
        @assign txt = Tpl.writeTok(txt, Tpl.ST_STRING(" then"))
        @assign txt = Tpl.writeText(txt, l_cmt__str)
        @assign txt = Tpl.softNewLine(txt)
        @assign txt = Tpl.pushBlock(txt, Tpl.BT_INDENT(2))
        @assign txt = Tpl.writeText(txt, l_when__body__str)
        @assign txt = Tpl.softNewLine(txt)
        @assign txt = Tpl.popBlock(txt)
        @assign txt = Tpl.writeText(txt, l_elsewhen__str)
        @assign txt = Tpl.softNewLine(txt)
        @assign txt = Tpl.writeTok(txt, Tpl.ST_STRING("end when;"))
        txt
      end

      (txt, _, _) => begin
        txt
      end
    end
  end
  return out_txt
end

function dumpTryStatement(
  in_txt::Tpl.Text,
  in_a_try__statement::SCode.Statement,
  in_a_options::SCodeDump.SCodeDumpOptions,
)::Tpl.Text
  local out_txt::Tpl.Text

  @assign out_txt = begin
    local txt::Tpl.Text
    local a_options::SCodeDump.SCodeDumpOptions
    local i_elseBody::List{SCode.Statement}
    local i_body::List{SCode.Statement}
    local i_comment::SCode.Comment
    local l_algs2::Tpl.Text
    local l_algs1::Tpl.Text
    local l_cmt__str::Tpl.Text
    @match (in_txt, in_a_try__statement, in_a_options) begin
      (
        txt,
        SCode.ALG_TRY(comment = i_comment, body = i_body, elseBody = i_elseBody),
        a_options,
      ) => begin
        @assign l_cmt__str = dumpComment(Tpl.emptyTxt, i_comment, a_options)
        @assign l_algs1 = dumpStatements(Tpl.emptyTxt, i_body, a_options)
        @assign l_algs2 = dumpStatements(Tpl.emptyTxt, i_elseBody, a_options)
        @assign txt = Tpl.writeTok(txt, Tpl.ST_LINE("try\\n"))
        @assign txt = Tpl.pushBlock(txt, Tpl.BT_INDENT(2))
        @assign txt = Tpl.writeText(txt, l_algs1)
        @assign txt = Tpl.softNewLine(txt)
        @assign txt = Tpl.popBlock(txt)
        @assign txt = Tpl.writeTok(txt, Tpl.ST_LINE("else\\n"))
        @assign txt = Tpl.pushBlock(txt, Tpl.BT_INDENT(2))
        @assign txt = Tpl.writeText(txt, l_algs2)
        @assign txt = Tpl.softNewLine(txt)
        @assign txt = Tpl.popBlock(txt)
        @assign txt = Tpl.writeTok(txt, Tpl.ST_STRING("end try"))
        @assign txt = Tpl.writeText(txt, l_cmt__str)
        @assign txt = Tpl.writeTok(txt, Tpl.ST_STRING(";"))
        txt
      end

      (txt, _, _) => begin
        txt
      end
    end
  end
  return out_txt
end

function dumpPrefixes(
  in_txt::Tpl.Text,
  in_a_prefixes::SCode.Prefixes,
  in_a_each::String,
)::Tpl.Text
  local out_txt::Tpl.Text

  @assign out_txt = begin
    local txt::Tpl.Text
    local a_each::String
    local i_replaceablePrefix::SCode.Replaceable
    local i_innerOuter::Absyn.InnerOuter
    local i_finalPrefix::SCode.Final
    local i_redeclarePrefix::SCode.Redeclare
    local l_replaceable__str::Tpl.Text
    local l_io__str::Tpl.Text
    local l_final__str::Tpl.Text
    local l_redeclare__str::Tpl.Text
    @match (in_txt, in_a_prefixes, in_a_each) begin
      (
        txt,
        SCode.PREFIXES(
          redeclarePrefix = i_redeclarePrefix,
          finalPrefix = i_finalPrefix,
          innerOuter = i_innerOuter,
          replaceablePrefix = i_replaceablePrefix,
        ),
        a_each,
      ) => begin
        @assign l_redeclare__str = dumpRedeclare(Tpl.emptyTxt, i_redeclarePrefix)
        @assign l_final__str = dumpFinal(Tpl.emptyTxt, i_finalPrefix)
        @assign l_io__str = dumpInnerOuter(Tpl.emptyTxt, i_innerOuter)
        @assign l_replaceable__str = dumpReplaceable(Tpl.emptyTxt, i_replaceablePrefix)
        @assign txt = Tpl.writeText(txt, l_redeclare__str)
        @assign txt = Tpl.writeStr(txt, a_each)
        @assign txt = Tpl.writeText(txt, l_final__str)
        @assign txt = Tpl.writeText(txt, l_io__str)
        @assign txt = Tpl.writeText(txt, l_replaceable__str)
        txt
      end

      (txt, _, _) => begin
        txt
      end
    end
  end
  return out_txt
end

function dumpVisibility(in_txt::Tpl.Text, in_a_visibility::SCode.Visibility)::Tpl.Text
  local out_txt::Tpl.Text

  @assign out_txt = begin
    local txt::Tpl.Text
    @match (in_txt, in_a_visibility) begin
      (txt, SCode.PROTECTED(__)) => begin
        @assign txt = Tpl.writeTok(txt, Tpl.ST_STRING("protected "))
        txt
      end

      (txt, _) => begin
        txt
      end
    end
  end
  return out_txt
end

function dumpRedeclare(in_txt::Tpl.Text, in_a_redeclare::SCode.Redeclare)::Tpl.Text
  local out_txt::Tpl.Text

  @assign out_txt = begin
    local txt::Tpl.Text
    @match (in_txt, in_a_redeclare) begin
      (txt, SCode.REDECLARE(__)) => begin
        @assign txt = Tpl.writeTok(txt, Tpl.ST_STRING("redeclare "))
        txt
      end

      (txt, _) => begin
        txt
      end
    end
  end
  return out_txt
end

function dumpFinal(in_txt::Tpl.Text, in_a_final::SCode.Final)::Tpl.Text
  local out_txt::Tpl.Text

  @assign out_txt = begin
    local txt::Tpl.Text
    @match (in_txt, in_a_final) begin
      (txt, SCode.FINAL(__)) => begin
        @assign txt = Tpl.writeTok(txt, Tpl.ST_STRING("final "))
        txt
      end

      (txt, _) => begin
        txt
      end
    end
  end
  return out_txt
end

function dumpInnerOuter(in_txt::Tpl.Text, in_a_innerOuter::Absyn.InnerOuter)::Tpl.Text
  local out_txt::Tpl.Text

  @assign out_txt = begin
    local txt::Tpl.Text
    @match (in_txt, in_a_innerOuter) begin
      (txt, Absyn.INNER(__)) => begin
        @assign txt = Tpl.writeTok(txt, Tpl.ST_STRING("inner "))
        txt
      end

      (txt, Absyn.OUTER(__)) => begin
        @assign txt = Tpl.writeTok(txt, Tpl.ST_STRING("outer "))
        txt
      end

      (txt, Absyn.INNER_OUTER(__)) => begin
        @assign txt = Tpl.writeTok(txt, Tpl.ST_STRING("inner outer "))
        txt
      end

      (txt, _) => begin
        txt
      end
    end
  end
  return out_txt
end

function dumpReplaceable(in_txt::Tpl.Text, in_a_replaceable::SCode.Replaceable)::Tpl.Text
  local out_txt::Tpl.Text

  @assign out_txt = begin
    local txt::Tpl.Text
    @match (in_txt, in_a_replaceable) begin
      (txt, SCode.REPLACEABLE(cc = _)) => begin
        @assign txt = Tpl.writeTok(txt, Tpl.ST_STRING("replaceable "))
        txt
      end

      (txt, _) => begin
        txt
      end
    end
  end
  return out_txt
end

function dumpReplaceableConstrainClass(
  in_txt::Tpl.Text,
  in_a_replaceable::SCode.Prefixes,
  in_a_options::SCodeDump.SCodeDumpOptions,
)::Tpl.Text
  local out_txt::Tpl.Text

  @assign out_txt = begin
    local txt::Tpl.Text
    local a_options::SCodeDump.SCodeDumpOptions
    local i_cc__mod::SCode.Mod
    local i_cc__path::Absyn.Path
    local l_mod__str::Tpl.Text
    local l_path__str::Tpl.Text
    @match (in_txt, in_a_replaceable, in_a_options) begin
      (
        txt,
        SCode.PREFIXES(
          replaceablePrefix = SCode.REPLACEABLE(
            cc = SOME(SCode.CONSTRAINCLASS(
              constrainingClass = i_cc__path,
              modifier = i_cc__mod,
            )),
          ),
        ),
        a_options,
      ) => begin
        @assign l_path__str = AbsynDumpTpl.dumpPath(Tpl.emptyTxt, i_cc__path)
        @assign l_mod__str = dumpModifier(Tpl.emptyTxt, i_cc__mod, a_options)
        @assign txt = Tpl.pushBlock(txt, Tpl.BT_INDENT(1))
        @assign txt = Tpl.writeTok(txt, Tpl.ST_STRING("constrainedby "))
        @assign txt = Tpl.writeText(txt, l_path__str)
        @assign txt = Tpl.writeText(txt, l_mod__str)
        @assign txt = Tpl.popBlock(txt)
        txt
      end

      (txt, _, _) => begin
        txt
      end
    end
  end
  return out_txt
end

function dumpEach(in_txt::Tpl.Text, in_a_each::SCode.Each)::Tpl.Text
  local out_txt::Tpl.Text

  @assign out_txt = begin
    local txt::Tpl.Text
    @match (in_txt, in_a_each) begin
      (txt, SCode.EACH(__)) => begin
        @assign txt = Tpl.writeTok(txt, Tpl.ST_STRING("each "))
        txt
      end

      (txt, _) => begin
        txt
      end
    end
  end
  return out_txt
end

function dumpEncapsulated(in_txt::Tpl.Text, in_a_encapsulated::SCode.Encapsulated)::Tpl.Text
  local out_txt::Tpl.Text

  @assign out_txt = begin
    local txt::Tpl.Text
    @match (in_txt, in_a_encapsulated) begin
      (txt, SCode.ENCAPSULATED(__)) => begin
        @assign txt = Tpl.writeTok(txt, Tpl.ST_STRING("encapsulated "))
        txt
      end

      (txt, _) => begin
        txt
      end
    end
  end
  return out_txt
end

function dumpPartial(in_txt::Tpl.Text, in_a_partial::SCode.Partial)::Tpl.Text
  local out_txt::Tpl.Text

  @assign out_txt = begin
    local txt::Tpl.Text
    @match (in_txt, in_a_partial) begin
      (txt, SCode.PARTIAL(__)) => begin
        @assign txt = Tpl.writeTok(txt, Tpl.ST_STRING("partial "))
        txt
      end

      (txt, _) => begin
        txt
      end
    end
  end
  return out_txt
end

function fun_105(in_txt::Tpl.Text, in_a_isOperator::Bool)::Tpl.Text
  local out_txt::Tpl.Text

  @assign out_txt = begin
    local txt::Tpl.Text
    @match (in_txt, in_a_isOperator) begin
      (txt, false) => begin
        @assign txt = Tpl.writeTok(txt, Tpl.ST_STRING("record"))
        txt
      end

      (txt, _) => begin
        @assign txt = Tpl.writeTok(txt, Tpl.ST_STRING("operator record"))
        txt
      end
    end
  end
  return out_txt
end

function fun_106(in_txt::Tpl.Text, in_a_isExpandable::Bool)::Tpl.Text
  local out_txt::Tpl.Text

  @assign out_txt = begin
    local txt::Tpl.Text
    @match (in_txt, in_a_isExpandable) begin
      (txt, false) => begin
        @assign txt = Tpl.writeTok(txt, Tpl.ST_STRING("connector"))
        txt
      end

      (txt, _) => begin
        @assign txt = Tpl.writeTok(txt, Tpl.ST_STRING("expandable connector"))
        txt
      end
    end
  end
  return out_txt
end

function dumpRestriction(in_txt::Tpl.Text, in_a_restriction::SCode.Restriction)::Tpl.Text
  local out_txt::Tpl.Text

  @assign out_txt = begin
    local txt::Tpl.Text
    local i_functionRestriction::SCode.FunctionRestriction
    local i_isExpandable::Bool
    local i_isOperator::Bool
    @match (in_txt, in_a_restriction) begin
      (txt, SCode.R_CLASS(__)) => begin
        @assign txt = Tpl.writeTok(txt, Tpl.ST_STRING("class"))
        txt
      end

      (txt, SCode.R_OPTIMIZATION(__)) => begin
        @assign txt = Tpl.writeTok(txt, Tpl.ST_STRING("optimization"))
        txt
      end

      (txt, SCode.R_MODEL(__)) => begin
        @assign txt = Tpl.writeTok(txt, Tpl.ST_STRING("model"))
        txt
      end

      (txt, SCode.R_RECORD(isOperator = i_isOperator)) => begin
        @assign txt = fun_105(txt, i_isOperator)
        txt
      end

      (txt, SCode.R_OPERATOR(__)) => begin
        @assign txt = Tpl.writeTok(txt, Tpl.ST_STRING("operator"))
        txt
      end

      (txt, SCode.R_BLOCK(__)) => begin
        @assign txt = Tpl.writeTok(txt, Tpl.ST_STRING("block"))
        txt
      end

      (txt, SCode.R_CONNECTOR(isExpandable = i_isExpandable)) => begin
        @assign txt = fun_106(txt, i_isExpandable)
        txt
      end

      (txt, SCode.R_OPERATOR(__)) => begin
        @assign txt = Tpl.writeTok(txt, Tpl.ST_STRING("operator"))
        txt
      end

      (txt, SCode.R_TYPE(__)) => begin
        @assign txt = Tpl.writeTok(txt, Tpl.ST_STRING("type"))
        txt
      end

      (txt, SCode.R_PACKAGE(__)) => begin
        @assign txt = Tpl.writeTok(txt, Tpl.ST_STRING("package"))
        txt
      end

      (txt, SCode.R_FUNCTION(functionRestriction = i_functionRestriction)) => begin
        @assign txt = dumpFunctionRestriction(txt, i_functionRestriction)
        txt
      end

      (txt, SCode.R_ENUMERATION(__)) => begin
        @assign txt = Tpl.writeTok(txt, Tpl.ST_STRING("enumeration"))
        txt
      end

      (txt, SCode.R_PREDEFINED_INTEGER(__)) => begin
        @assign txt = Tpl.writeTok(txt, Tpl.ST_STRING("IntegerType"))
        txt
      end

      (txt, SCode.R_PREDEFINED_REAL(__)) => begin
        @assign txt = Tpl.writeTok(txt, Tpl.ST_STRING("RealType"))
        txt
      end

      (txt, SCode.R_PREDEFINED_STRING(__)) => begin
        @assign txt = Tpl.writeTok(txt, Tpl.ST_STRING("StringType"))
        txt
      end

      (txt, SCode.R_PREDEFINED_BOOLEAN(__)) => begin
        @assign txt = Tpl.writeTok(txt, Tpl.ST_STRING("BooleanType"))
        txt
      end

      (txt, SCode.R_PREDEFINED_ENUMERATION(__)) => begin
        @assign txt = Tpl.writeTok(txt, Tpl.ST_STRING("EnumType"))
        txt
      end

      (txt, SCode.R_METARECORD(name = _)) => begin
        @assign txt = Tpl.writeTok(txt, Tpl.ST_STRING("record"))
        txt
      end

      (txt, SCode.R_UNIONTYPE(typeVars = _)) => begin
        @assign txt = Tpl.writeTok(txt, Tpl.ST_STRING("uniontype"))
        txt
      end

      (txt, _) => begin
        @assign txt = errorMsg(txt, "SCodeDump.dumpRestriction: Unknown restriction.")
        txt
      end
    end
  end
  return out_txt
end

function lm_108(in_txt::Tpl.Text, in_items::List{<:String})::Tpl.Text
  local out_txt::Tpl.Text

  @assign out_txt = begin
    local txt::Tpl.Text
    local rest::List{String}
    local i_tv::String
    @match (in_txt, in_items) begin
      (txt, nil()) => begin
        txt
      end

      (txt, i_tv <| rest) => begin
        @assign txt = Tpl.writeStr(txt, i_tv)
        @assign txt = Tpl.nextIter(txt)
        @assign txt = lm_108(txt, rest)
        txt
      end
    end
  end
  return out_txt
end

function fun_109(in_txt::Tpl.Text, in_a_typeVars::List{<:String})::Tpl.Text
  local out_txt::Tpl.Text

  @assign out_txt = begin
    local txt::Tpl.Text
    local i_typeVars::List{String}
    @match (in_txt, in_a_typeVars) begin
      (txt, nil()) => begin
        txt
      end

      (txt, i_typeVars) => begin
        @assign txt = Tpl.writeTok(txt, Tpl.ST_STRING("<"))
        @assign txt = Tpl.pushIter(
          txt,
          Tpl.ITER_OPTIONS(
            0,
            NONE(),
            SOME(Tpl.ST_STRING(",")),
            0,
            0,
            Tpl.ST_NEW_LINE(),
            0,
            Tpl.ST_NEW_LINE(),
          ),
        )
        @assign txt = lm_108(txt, i_typeVars)
        @assign txt = Tpl.popIter(txt)
        @assign txt = Tpl.writeTok(txt, Tpl.ST_STRING(">"))
        txt
      end
    end
  end
  return out_txt
end

function dumpRestrictionTypeVars(
  in_txt::Tpl.Text,
  in_a_restriction::SCode.Restriction,
)::Tpl.Text
  local out_txt::Tpl.Text

  @assign out_txt = begin
    local txt::Tpl.Text
    local i_typeVars::List{String}
    @match (in_txt, in_a_restriction) begin
      (txt, SCode.R_UNIONTYPE(typeVars = i_typeVars)) => begin
        @assign txt = fun_109(txt, i_typeVars)
        txt
      end

      (txt, _) => begin
        txt
      end
    end
  end
  return out_txt
end

function fun_111(in_txt::Tpl.Text, in_a_isImpure::Bool)::Tpl.Text
  local out_txt::Tpl.Text

  @assign out_txt = begin
    local txt::Tpl.Text
    @match (in_txt, in_a_isImpure) begin
      (txt, false) => begin
        @assign txt = Tpl.writeTok(txt, Tpl.ST_STRING("function"))
        txt
      end

      (txt, _) => begin
        @assign txt = Tpl.writeTok(txt, Tpl.ST_STRING("impure function"))
        txt
      end
    end
  end
  return out_txt
end

function fun_112(in_txt::Tpl.Text, in_a_isImpure::Bool)::Tpl.Text
  local out_txt::Tpl.Text

  @assign out_txt = begin
    local txt::Tpl.Text
    @match (in_txt, in_a_isImpure) begin
      (txt, false) => begin
        @assign txt = Tpl.writeTok(txt, Tpl.ST_STRING("function"))
        txt
      end

      (txt, _) => begin
        @assign txt = Tpl.writeTok(txt, Tpl.ST_STRING("impure function"))
        txt
      end
    end
  end
  return out_txt
end

function dumpFunctionRestriction(
  in_txt::Tpl.Text,
  in_a_funcRest::SCode.FunctionRestriction,
)::Tpl.Text
  local out_txt::Tpl.Text

  @assign out_txt = begin
    local txt::Tpl.Text
    local i_isImpure::Bool
    @match (in_txt, in_a_funcRest) begin
      (txt, SCode.FR_NORMAL_FUNCTION(isImpure = i_isImpure)) => begin
        @assign txt = fun_111(txt, i_isImpure)
        txt
      end

      (txt, SCode.FR_EXTERNAL_FUNCTION(isImpure = i_isImpure)) => begin
        @assign txt = fun_112(txt, i_isImpure)
        txt
      end

      (txt, SCode.FR_OPERATOR_FUNCTION(__)) => begin
        @assign txt = Tpl.writeTok(txt, Tpl.ST_STRING("operator function"))
        txt
      end

      (txt, SCode.FR_RECORD_CONSTRUCTOR(__)) => begin
        @assign txt = Tpl.writeTok(txt, Tpl.ST_STRING("function"))
        txt
      end

      (txt, _) => begin
        @assign txt = errorMsg(
          txt,
          "SCodeDump.dumpFunctionRestriction: Unknown Function restriction.",
        )
        txt
      end
    end
  end
  return out_txt
end

function lm_114(
  in_txt::Tpl.Text,
  in_items::List{<:SCode.SubMod},
  in_a_options::SCodeDump.SCodeDumpOptions,
)::Tpl.Text
  local out_txt::Tpl.Text

  @assign out_txt = begin
    local txt::Tpl.Text
    local rest::List{SCode.SubMod}
    local a_options::SCodeDump.SCodeDumpOptions
    local i_submod::SCode.SubMod
    @match (in_txt, in_items, in_a_options) begin
      (txt, nil(), _) => begin
        txt
      end

      (txt, i_submod <| rest, a_options) => begin
        @assign txt = dumpSubModifier(txt, i_submod, a_options)
        @assign txt = Tpl.nextIter(txt)
        @assign txt = lm_114(txt, rest, a_options)
        txt
      end
    end
  end
  return out_txt
end

function fun_115(
  in_txt::Tpl.Text,
  in_a_subModLst::List{<:SCode.SubMod},
  in_a_options::SCodeDump.SCodeDumpOptions,
)::Tpl.Text
  local out_txt::Tpl.Text

  @assign out_txt = begin
    local txt::Tpl.Text
    local a_options::SCodeDump.SCodeDumpOptions
    local i_subModLst::List{SCode.SubMod}
    @match (in_txt, in_a_subModLst, in_a_options) begin
      (txt, nil(), _) => begin
        txt
      end

      (txt, i_subModLst, a_options) => begin
        @assign txt = Tpl.writeTok(txt, Tpl.ST_STRING("("))
        @assign txt = Tpl.pushIter(
          txt,
          Tpl.ITER_OPTIONS(
            0,
            NONE(),
            SOME(Tpl.ST_STRING(", ")),
            0,
            0,
            Tpl.ST_NEW_LINE(),
            0,
            Tpl.ST_NEW_LINE(),
          ),
        )
        @assign txt = lm_114(txt, i_subModLst, a_options)
        @assign txt = Tpl.popIter(txt)
        @assign txt = Tpl.writeTok(txt, Tpl.ST_STRING(")"))
        txt
      end
    end
  end
  return out_txt
end

function dumpModifier(
  in_txt::Tpl.Text,
  in_a_modifier::SCode.Mod,
  in_a_options::SCodeDump.SCodeDumpOptions,
)::Tpl.Text
  local out_txt::Tpl.Text

  @assign out_txt = begin
    local txt::Tpl.Text
    local a_options::SCodeDump.SCodeDumpOptions
    local i_subModLst::List{SCode.SubMod}
    local i_binding::Option{Absyn.Exp}
    local l_submod__str::Tpl.Text
    local l_binding__str::Tpl.Text
    @match (in_txt, in_a_modifier, in_a_options) begin
      (txt, SCode.MOD(binding = i_binding, subModLst = i_subModLst), a_options) => begin
        @assign l_binding__str = dumpModifierBinding(Tpl.emptyTxt, i_binding)
        @assign l_submod__str = fun_115(Tpl.emptyTxt, i_subModLst, a_options)
        @assign txt = Tpl.writeText(txt, l_submod__str)
        @assign txt = Tpl.writeText(txt, l_binding__str)
        txt
      end

      (txt, _, _) => begin
        txt
      end
    end
  end
  return out_txt
end

function lm_117(
  in_txt::Tpl.Text,
  in_items::List{<:SCode.SubMod},
  in_a_options::SCodeDump.SCodeDumpOptions,
)::Tpl.Text
  local out_txt::Tpl.Text

  @assign out_txt = begin
    local txt::Tpl.Text
    local rest::List{SCode.SubMod}
    local a_options::SCodeDump.SCodeDumpOptions
    local i_submod::SCode.SubMod
    @match (in_txt, in_items, in_a_options) begin
      (txt, nil(), _) => begin
        txt
      end

      (txt, i_submod <| rest, a_options) => begin
        @assign txt = dumpAnnotationSubModifier(txt, i_submod, a_options)
        @assign txt = Tpl.nextIter(txt)
        @assign txt = lm_117(txt, rest, a_options)
        txt
      end
    end
  end
  return out_txt
end

function fun_118(in_txt::Tpl.Text, in_a_text::Tpl.Text)::Tpl.Text
  local out_txt::Tpl.Text

  @assign out_txt = begin
    local txt::Tpl.Text
    local i_text::Tpl.Text
    @match (in_txt, in_a_text) begin
      (txt, Tpl.MEM_TEXT(tokens = nil())) => begin
        txt
      end

      (txt, i_text) => begin
        @assign txt = Tpl.writeTok(txt, Tpl.ST_STRING("("))
        @assign txt = Tpl.writeText(txt, i_text)
        @assign txt = Tpl.writeTok(txt, Tpl.ST_STRING(")"))
        txt
      end
    end
  end
  return out_txt
end

function dumpAnnotationModifier(
  in_txt::Tpl.Text,
  in_a_modifier::SCode.Mod,
  in_a_options::SCodeDump.SCodeDumpOptions,
)::Tpl.Text
  local out_txt::Tpl.Text

  @assign out_txt = begin
    local txt::Tpl.Text
    local a_options::SCodeDump.SCodeDumpOptions
    local i_subModLst::List{SCode.SubMod}
    local i_binding::Option{Absyn.Exp}
    local l_submod__str::Tpl.Text
    local l_text::Tpl.Text
    local l_binding__str::Tpl.Text
    @match (in_txt, in_a_modifier, in_a_options) begin
      (txt, SCode.MOD(binding = i_binding, subModLst = i_subModLst), a_options) => begin
        @assign l_binding__str = dumpModifierBinding(Tpl.emptyTxt, i_binding)
        @assign l_text = Tpl.pushIter(
          Tpl.emptyTxt,
          Tpl.ITER_OPTIONS(
            0,
            NONE(),
            SOME(Tpl.ST_STRING(", ")),
            0,
            0,
            Tpl.ST_NEW_LINE(),
            0,
            Tpl.ST_NEW_LINE(),
          ),
        )
        @assign l_text = lm_117(l_text, i_subModLst, a_options)
        @assign l_text = Tpl.popIter(l_text)
        @assign l_submod__str = fun_118(Tpl.emptyTxt, l_text)
        @assign txt = Tpl.writeText(txt, l_submod__str)
        @assign txt = Tpl.writeText(txt, l_binding__str)
        txt
      end

      (txt, _, _) => begin
        txt
      end
    end
  end
  return out_txt
end

function dumpModifierPrefix(in_txt::Tpl.Text, in_a_modifier::SCode.Mod)::Tpl.Text
  local out_txt::Tpl.Text

  @assign out_txt = begin
    local txt::Tpl.Text
    local i_eachPrefix::SCode.Each
    local i_finalPrefix::SCode.Final
    local l_each__str::Tpl.Text
    local l_final__str::Tpl.Text
    @match (in_txt, in_a_modifier) begin
      (txt, SCode.MOD(finalPrefix = i_finalPrefix, eachPrefix = i_eachPrefix)) => begin
        @assign l_final__str = dumpFinal(Tpl.emptyTxt, i_finalPrefix)
        @assign l_each__str = dumpEach(Tpl.emptyTxt, i_eachPrefix)
        @assign txt = Tpl.writeText(txt, l_each__str)
        @assign txt = Tpl.writeText(txt, l_final__str)
        txt
      end

      (txt, SCode.REDECL(finalPrefix = i_finalPrefix, eachPrefix = i_eachPrefix)) => begin
        @assign l_final__str = dumpFinal(Tpl.emptyTxt, i_finalPrefix)
        @assign l_each__str = dumpEach(Tpl.emptyTxt, i_eachPrefix)
        @assign txt = Tpl.writeText(txt, l_each__str)
        @assign txt = Tpl.writeText(txt, l_final__str)
        txt
      end

      (txt, _) => begin
        txt
      end
    end
  end
  return out_txt
end

function dumpRedeclModifier(
  in_txt::Tpl.Text,
  in_a_modifier::SCode.Mod,
  in_a_options::SCodeDump.SCodeDumpOptions,
)::Tpl.Text
  local out_txt::Tpl.Text

  @assign out_txt = begin
    local txt::Tpl.Text
    local a_options::SCodeDump.SCodeDumpOptions
    local i_element::SCode.Element
    local i_eachPrefix::SCode.Each
    local l_each__str::Tpl.Text
    @match (in_txt, in_a_modifier, in_a_options) begin
      (txt, SCode.REDECL(eachPrefix = i_eachPrefix, element = i_element), a_options) =>
        begin
          @assign l_each__str = dumpEach(Tpl.emptyTxt, i_eachPrefix)
          @assign txt =
            dumpElement(txt, i_element, Tpl.textString(l_each__str), a_options)
          txt
        end

      (txt, _, _) => begin
        txt
      end
    end
  end
  return out_txt
end

function dumpModifierBinding(in_txt::Tpl.Text, in_a_binding::Option{<:Absyn.Exp})::Tpl.Text
  local out_txt::Tpl.Text

  @assign out_txt = begin
    local txt::Tpl.Text
    local i_exp::Absyn.Exp
    @match (in_txt, in_a_binding) begin
      (txt, SOME(i_exp)) => begin
        @assign txt = Tpl.writeTok(txt, Tpl.ST_STRING(" "))
        @assign txt = Tpl.writeTok(txt, Tpl.ST_STRING("= "))
        @assign txt = AbsynDumpTpl.dumpExp(txt, i_exp)
        txt
      end

      (txt, _) => begin
        txt
      end
    end
  end
  return out_txt
end

function dumpSubModifier(
  in_txt::Tpl.Text,
  in_a_submod::SCode.SubMod,
  in_a_options::SCodeDump.SCodeDumpOptions,
)::Tpl.Text
  local out_txt::Tpl.Text

  @assign out_txt = begin
    local txt::Tpl.Text
    local a_options::SCodeDump.SCodeDumpOptions
    local i_ident::SCode.Ident
    local i_mod::SCode.Mod
    @match (in_txt, in_a_submod, in_a_options) begin
      (
        txt,
        SCode.NAMEMOD(mod = i_mod && SCode.MOD(finalPrefix = _), ident = i_ident),
        a_options,
      ) => begin
        @assign txt = dumpModifierPrefix(txt, i_mod)
        @assign txt = Tpl.writeStr(txt, i_ident)
        @assign txt = dumpModifier(txt, i_mod, a_options)
        txt
      end

      (txt, SCode.NAMEMOD(mod = i_mod && SCode.REDECL(finalPrefix = _)), a_options) =>
        begin
          @assign txt = dumpRedeclModifier(txt, i_mod, a_options)
          txt
        end

      (txt, _, _) => begin
        txt
      end
    end
  end
  return out_txt
end

function fun_124(
  in_txt::Tpl.Text,
  in_a_ident::SCode.Ident,
  in_a_options::SCodeDump.SCodeDumpOptions,
  in_a_nameMod::SCode.Mod,
)::Tpl.Text
  local out_txt::Tpl.Text

  @assign out_txt = begin
    local txt::Tpl.Text
    local a_options::SCodeDump.SCodeDumpOptions
    local a_nameMod::SCode.Mod
    local i_ident::SCode.Ident
    @match (in_txt, in_a_ident, in_a_options, in_a_nameMod) begin
      (txt, "choices", _, _) => begin
        txt
      end

      (txt, "Documentation", _, _) => begin
        txt
      end

      (txt, "Dialog", _, _) => begin
        txt
      end

      (txt, "Diagram", _, _) => begin
        txt
      end

      (txt, "Icon", _, _) => begin
        txt
      end

      (txt, "Line", _, _) => begin
        txt
      end

      (txt, "Placement", _, _) => begin
        txt
      end

      (txt, "preferredView", _, _) => begin
        txt
      end

      (txt, "conversion", _, _) => begin
        txt
      end

      (txt, "defaultComponentName", _, _) => begin
        txt
      end

      (txt, "revisionId", _, _) => begin
        txt
      end

      (txt, "uses", _, _) => begin
        txt
      end

      (txt, i_ident, a_options, a_nameMod) => begin
        @assign txt = dumpModifierPrefix(txt, a_nameMod)
        @assign txt = Tpl.writeStr(txt, i_ident)
        @assign txt = dumpAnnotationModifier(txt, a_nameMod, a_options)
        txt
      end
    end
  end
  return out_txt
end

function fun_125(
  in_txt::Tpl.Text,
  in_mArg::Bool,
  in_a_mod::SCode.Mod,
  in_a_options::SCodeDump.SCodeDumpOptions,
  in_a_nameMod::SCode.Mod,
  in_a_ident::SCode.Ident,
)::Tpl.Text
  local out_txt::Tpl.Text

  @assign out_txt = begin
    local txt::Tpl.Text
    local a_mod::SCode.Mod
    local a_options::SCodeDump.SCodeDumpOptions
    local a_nameMod::SCode.Mod
    local a_ident::SCode.Ident
    @match (in_txt, in_mArg, in_a_mod, in_a_options, in_a_nameMod, in_a_ident) begin
      (txt, false, _, a_options, a_nameMod, a_ident) => begin
        @assign txt = fun_124(txt, a_ident, a_options, a_nameMod)
        txt
      end

      (txt, _, a_mod, a_options, a_nameMod, a_ident) => begin
        @assign txt = dumpModifierPrefix(txt, a_mod)
        @assign txt = Tpl.writeStr(txt, a_ident)
        @assign txt = dumpAnnotationModifier(txt, a_nameMod, a_options)
        txt
      end
    end
  end
  return out_txt
end

function dumpAnnotationSubModifier(
  in_txt::Tpl.Text,
  in_a_submod::SCode.SubMod,
  in_a_options::SCodeDump.SCodeDumpOptions,
)::Tpl.Text
  local out_txt::Tpl.Text

  @assign out_txt = begin
    local txt::Tpl.Text
    local a_options::SCodeDump.SCodeDumpOptions
    local i_mod::SCode.Mod
    local i_nameMod::SCode.Mod
    local i_ident::SCode.Ident
    local ret_0::Bool
    @match (in_txt, in_a_submod, in_a_options) begin
      (
        txt,
        SCode.NAMEMOD(
          mod = i_nameMod && i_mod && SCode.MOD(finalPrefix = _),
          ident = i_ident,
        ),
        a_options,
      ) => begin
        @assign ret_0 = Config.showAnnotations()
        @assign txt = fun_125(txt, ret_0, i_mod, a_options, i_nameMod, i_ident)
        txt
      end

      (txt, SCode.NAMEMOD(mod = i_mod && SCode.REDECL(finalPrefix = _)), a_options) =>
        begin
          @assign txt = dumpRedeclModifier(txt, i_mod, a_options)
          txt
        end

      (txt, _, _) => begin
        txt
      end
    end
  end
  return out_txt
end

function dumpAttributes(in_txt::Tpl.Text, in_a_attributes::SCode.Attributes)::Tpl.Text
  local out_txt::Tpl.Text

  @assign out_txt = begin
    local txt::Tpl.Text
    local i_direction::Absyn.Direction
    local i_variability::SCode.Variability
    local i_parallelism::SCode.Parallelism
    local i_connectorType::SCode.ConnectorType
    local l_dir__str::Tpl.Text
    local l_var__str::Tpl.Text
    local l_prl__str::Tpl.Text
    local l_ct__str::Tpl.Text
    @match (in_txt, in_a_attributes) begin
      (
        txt,
        SCode.ATTR(
          connectorType = i_connectorType,
          parallelism = i_parallelism,
          variability = i_variability,
          direction = i_direction,
        ),
      ) => begin
        @assign l_ct__str = dumpConnectorType(Tpl.emptyTxt, i_connectorType)
        @assign l_prl__str = dumpParallelism(Tpl.emptyTxt, i_parallelism)
        @assign l_var__str = dumpVariability(Tpl.emptyTxt, i_variability)
        @assign l_dir__str = dumpDirection(Tpl.emptyTxt, i_direction)
        @assign txt = Tpl.writeText(txt, l_prl__str)
        @assign txt = Tpl.writeText(txt, l_var__str)
        @assign txt = Tpl.writeText(txt, l_dir__str)
        @assign txt = Tpl.writeText(txt, l_ct__str)
        txt
      end

      (txt, _) => begin
        txt
      end
    end
  end
  return out_txt
end

function dumpConnectorType(
  in_txt::Tpl.Text,
  in_a_connectorType::SCode.ConnectorType,
)::Tpl.Text
  local out_txt::Tpl.Text

  @assign out_txt = begin
    local txt::Tpl.Text
    @match (in_txt, in_a_connectorType) begin
      (txt, SCode.FLOW(__)) => begin
        @assign txt = Tpl.writeTok(txt, Tpl.ST_STRING("flow "))
        txt
      end

      (txt, SCode.STREAM(__)) => begin
        @assign txt = Tpl.writeTok(txt, Tpl.ST_STRING("stream "))
        txt
      end

      (txt, _) => begin
        txt
      end
    end
  end
  return out_txt
end

function dumpParallelism(in_txt::Tpl.Text, in_a_parallelism::SCode.Parallelism)::Tpl.Text
  local out_txt::Tpl.Text

  @assign out_txt = begin
    local txt::Tpl.Text
    @match (in_txt, in_a_parallelism) begin
      (txt, SCode.PARGLOBAL(__)) => begin
        @assign txt = Tpl.writeTok(txt, Tpl.ST_STRING("parglobal "))
        txt
      end

      (txt, SCode.PARLOCAL(__)) => begin
        @assign txt = Tpl.writeTok(txt, Tpl.ST_STRING("parlocal "))
        txt
      end

      (txt, _) => begin
        txt
      end
    end
  end
  return out_txt
end

function dumpVariability(in_txt::Tpl.Text, in_a_variability::SCode.Variability)::Tpl.Text
  local out_txt::Tpl.Text

  @assign out_txt = begin
    local txt::Tpl.Text
    @match (in_txt, in_a_variability) begin
      (txt, SCode.DISCRETE(__)) => begin
        @assign txt = Tpl.writeTok(txt, Tpl.ST_STRING("discrete "))
        txt
      end

      (txt, SCode.PARAM(__)) => begin
        @assign txt = Tpl.writeTok(txt, Tpl.ST_STRING("parameter "))
        txt
      end

      (txt, SCode.CONST(__)) => begin
        @assign txt = Tpl.writeTok(txt, Tpl.ST_STRING("constant "))
        txt
      end

      (txt, _) => begin
        txt
      end
    end
  end
  return out_txt
end

function dumpDirection(in_txt::Tpl.Text, in_a_direction::Absyn.Direction)::Tpl.Text
  local out_txt::Tpl.Text

  @assign out_txt = begin
    local txt::Tpl.Text
    @match (in_txt, in_a_direction) begin
      (txt, Absyn.INPUT(__)) => begin
        @assign txt = Tpl.writeTok(txt, Tpl.ST_STRING("input "))
        txt
      end

      (txt, Absyn.OUTPUT(__)) => begin
        @assign txt = Tpl.writeTok(txt, Tpl.ST_STRING("output "))
        txt
      end

      (txt, Absyn.INPUT_OUTPUT(__)) => begin
        @assign txt = Tpl.writeTok(txt, Tpl.ST_STRING("input output "))
        txt
      end

      (txt, _) => begin
        txt
      end
    end
  end
  return out_txt
end

function dumpAttributeDim(in_txt::Tpl.Text, in_a_attributes::SCode.Attributes)::Tpl.Text
  local out_txt::Tpl.Text

  @assign out_txt = begin
    local txt::Tpl.Text
    local i_arrayDims::Absyn.ArrayDim
    @match (in_txt, in_a_attributes) begin
      (txt, SCode.ATTR(arrayDims = i_arrayDims)) => begin
        @assign txt = AbsynDumpTpl.dumpSubscripts(txt, i_arrayDims)
        txt
      end

      (txt, _) => begin
        txt
      end
    end
  end
  return out_txt
end

function dumpAnnotationOpt(
  in_txt::Tpl.Text,
  in_a_annotation::Option{<:SCode.Annotation},
  in_a_options::SCodeDump.SCodeDumpOptions,
)::Tpl.Text
  local out_txt::Tpl.Text

  @assign out_txt = begin
    local txt::Tpl.Text
    local a_options::SCodeDump.SCodeDumpOptions
    local i_ann::SCode.Annotation
    @match (in_txt, in_a_annotation, in_a_options) begin
      (txt, SOME(i_ann), a_options) => begin
        @assign txt = dumpAnnotation(txt, i_ann, a_options)
        txt
      end

      (txt, _, _) => begin
        txt
      end
    end
  end
  return out_txt
end

function fun_134(in_txt::Tpl.Text, in_a_modifStr::Tpl.Text)::Tpl.Text
  local out_txt::Tpl.Text

  @assign out_txt = begin
    local txt::Tpl.Text
    local i_modifStr::Tpl.Text
    @match (in_txt, in_a_modifStr) begin
      (txt, Tpl.MEM_TEXT(tokens = nil())) => begin
        txt
      end

      (txt, i_modifStr) => begin
        @assign txt = Tpl.writeTok(txt, Tpl.ST_STRING(" "))
        @assign txt = Tpl.writeTok(txt, Tpl.ST_STRING("annotation"))
        @assign txt = Tpl.writeText(txt, i_modifStr)
        txt
      end
    end
  end
  return out_txt
end

function dumpAnnotation(
  in_txt::Tpl.Text,
  in_a_annotation::SCode.Annotation,
  in_a_options::SCodeDump.SCodeDumpOptions,
)::Tpl.Text
  local out_txt::Tpl.Text

  @assign out_txt = begin
    local txt::Tpl.Text
    local a_options::SCodeDump.SCodeDumpOptions
    local i_modification::SCode.Mod
    local l_modifStr::Tpl.Text
    @match (in_txt, in_a_annotation, in_a_options) begin
      (txt, SCode.ANNOTATION(modification = i_modification), a_options) => begin
        @assign l_modifStr = dumpAnnotationModifier(Tpl.emptyTxt, i_modification, a_options)
        @assign txt = fun_134(txt, l_modifStr)
        txt
      end

      (txt, _, _) => begin
        txt
      end
    end
  end
  return out_txt
end

function fun_136(in_txt::Tpl.Text, in_a_annstr::Tpl.Text)::Tpl.Text
  local out_txt::Tpl.Text

  @assign out_txt = begin
    local txt::Tpl.Text
    local i_annstr::Tpl.Text
    @match (in_txt, in_a_annstr) begin
      (txt, Tpl.MEM_TEXT(tokens = nil())) => begin
        txt
      end

      (txt, i_annstr) => begin
        @assign txt = Tpl.writeTok(txt, Tpl.ST_STRING(" "))
        @assign txt = Tpl.writeText(txt, i_annstr)
        @assign txt = Tpl.writeTok(txt, Tpl.ST_STRING(";"))
        txt
      end
    end
  end
  return out_txt
end

function dumpAnnotationElement(
  txt::Tpl.Text,
  a_annotation::SCode.Annotation,
  a_options::SCodeDump.SCodeDumpOptions,
)::Tpl.Text
  local out_txt::Tpl.Text

  local l_annstr::Tpl.Text

  @assign l_annstr = dumpAnnotation(Tpl.emptyTxt, a_annotation, a_options)
  @assign out_txt = fun_136(txt, l_annstr)
  return out_txt
end

function dumpExternalDeclOpt(
  in_txt::Tpl.Text,
  in_a_externalDecl::Option{<:SCode.ExternalDecl},
  in_a_options::SCodeDump.SCodeDumpOptions,
)::Tpl.Text
  local out_txt::Tpl.Text

  @assign out_txt = begin
    local txt::Tpl.Text
    local a_options::SCodeDump.SCodeDumpOptions
    local i_extdecl::SCode.ExternalDecl
    @match (in_txt, in_a_externalDecl, in_a_options) begin
      (txt, SOME(i_extdecl), a_options) => begin
        @assign txt = dumpExternalDecl(txt, i_extdecl, a_options)
        txt
      end

      (txt, _, _) => begin
        txt
      end
    end
  end
  return out_txt
end

function fun_139(in_txt::Tpl.Text, in_a_funcName::Option{<:SCode.Ident})::Tpl.Text
  local out_txt::Tpl.Text

  @assign out_txt = begin
    local txt::Tpl.Text
    local i_name::SCode.Ident
    @match (in_txt, in_a_funcName) begin
      (txt, SOME(i_name)) => begin
        @assign txt = Tpl.writeStr(txt, i_name)
        txt
      end

      (txt, _) => begin
        txt
      end
    end
  end
  return out_txt
end

function lm_140(in_txt::Tpl.Text, in_items::List{<:Absyn.Exp})::Tpl.Text
  local out_txt::Tpl.Text

  @assign out_txt = begin
    local txt::Tpl.Text
    local rest::List{Absyn.Exp}
    local i_arg::Absyn.Exp
    @match (in_txt, in_items) begin
      (txt, nil()) => begin
        txt
      end

      (txt, i_arg <| rest) => begin
        @assign txt = AbsynDumpTpl.dumpExp(txt, i_arg)
        @assign txt = Tpl.nextIter(txt)
        @assign txt = lm_140(txt, rest)
        txt
      end
    end
  end
  return out_txt
end

function fun_141(
  in_txt::Tpl.Text,
  in_a_func__name__str::Tpl.Text,
  in_a_func__args__str::Tpl.Text,
)::Tpl.Text
  local out_txt::Tpl.Text

  @assign out_txt = begin
    local txt::Tpl.Text
    local a_func__args__str::Tpl.Text
    local i_func__name__str::Tpl.Text
    @match (in_txt, in_a_func__name__str, in_a_func__args__str) begin
      (txt, Tpl.MEM_TEXT(tokens = nil()), _) => begin
        txt
      end

      (txt, i_func__name__str, a_func__args__str) => begin
        @assign txt = Tpl.pushBlock(txt, Tpl.BT_INDENT(1))
        @assign txt = Tpl.writeText(txt, i_func__name__str)
        @assign txt = Tpl.writeTok(txt, Tpl.ST_STRING("("))
        @assign txt = Tpl.writeText(txt, a_func__args__str)
        @assign txt = Tpl.writeTok(txt, Tpl.ST_STRING(")"))
        @assign txt = Tpl.popBlock(txt)
        txt
      end
    end
  end
  return out_txt
end

function fun_142(in_txt::Tpl.Text, in_a_lang::Option{<:String})::Tpl.Text
  local out_txt::Tpl.Text

  @assign out_txt = begin
    local txt::Tpl.Text
    local i_l::String
    @match (in_txt, in_a_lang) begin
      (txt, SOME(i_l)) => begin
        @assign txt = Tpl.pushBlock(txt, Tpl.BT_INDENT(1))
        @assign txt = Tpl.writeTok(txt, Tpl.ST_STRING("\\"))
        @assign txt = Tpl.writeStr(txt, i_l)
        @assign txt = Tpl.writeTok(txt, Tpl.ST_STRING("\\"))
        @assign txt = Tpl.popBlock(txt)
        txt
      end

      (txt, _) => begin
        txt
      end
    end
  end
  return out_txt
end

function fun_143(in_txt::Tpl.Text, in_a_output__::Option{<:Absyn.ComponentRef})::Tpl.Text
  local out_txt::Tpl.Text

  @assign out_txt = begin
    local txt::Tpl.Text
    local i_name::Absyn.ComponentRef
    @match (in_txt, in_a_output__) begin
      (txt, SOME(i_name)) => begin
        @assign txt = Tpl.pushBlock(txt, Tpl.BT_INDENT(1))
        @assign txt = AbsynDumpTpl.dumpCref(txt, i_name)
        @assign txt = Tpl.writeTok(txt, Tpl.ST_STRING(" ="))
        @assign txt = Tpl.popBlock(txt)
        txt
      end

      (txt, _) => begin
        txt
      end
    end
  end
  return out_txt
end

function fun_144(
  in_txt::Tpl.Text,
  in_a_externalDecl::SCode.ExternalDecl,
  in_a_options::SCodeDump.SCodeDumpOptions,
)::Tpl.Text
  local out_txt::Tpl.Text

  @assign out_txt = begin
    local txt::Tpl.Text
    local a_options::SCodeDump.SCodeDumpOptions
    local i_output__::Option{Absyn.ComponentRef}
    local i_annotation__::Option{SCode.Annotation}
    local i_lang::Option{String}
    local i_args::List{Absyn.Exp}
    local i_funcName::Option{SCode.Ident}
    local l_output__str::Tpl.Text
    local l_ann__str::Tpl.Text
    local l_lang__str::Tpl.Text
    local l_func__str::Tpl.Text
    local l_func__args__str::Tpl.Text
    local l_func__name__str::Tpl.Text
    @match (in_txt, in_a_externalDecl, in_a_options) begin
      (
        txt,
        SCode.EXTERNALDECL(
          funcName = i_funcName,
          args = i_args,
          lang = i_lang,
          annotation_ = i_annotation__,
          output_ = i_output__,
        ),
        a_options,
      ) => begin
        @assign l_func__name__str = fun_139(Tpl.emptyTxt, i_funcName)
        @assign l_func__args__str = Tpl.pushIter(
          Tpl.emptyTxt,
          Tpl.ITER_OPTIONS(
            0,
            NONE(),
            SOME(Tpl.ST_STRING(", ")),
            0,
            0,
            Tpl.ST_NEW_LINE(),
            0,
            Tpl.ST_NEW_LINE(),
          ),
        )
        @assign l_func__args__str = lm_140(l_func__args__str, i_args)
        @assign l_func__args__str = Tpl.popIter(l_func__args__str)
        @assign l_func__str = fun_141(Tpl.emptyTxt, l_func__name__str, l_func__args__str)
        @assign l_lang__str = fun_142(Tpl.emptyTxt, i_lang)
        @assign l_ann__str = dumpAnnotationOpt(Tpl.emptyTxt, i_annotation__, a_options)
        @assign l_output__str = fun_143(Tpl.emptyTxt, i_output__)
        @assign txt = Tpl.writeTok(txt, Tpl.ST_STRING("external"))
        @assign txt = Tpl.writeText(txt, l_lang__str)
        @assign txt = Tpl.writeText(txt, l_output__str)
        @assign txt = Tpl.writeText(txt, l_func__str)
        @assign txt = Tpl.writeText(txt, l_ann__str)
        @assign txt = Tpl.writeTok(txt, Tpl.ST_STRING(";"))
        txt
      end

      (txt, _, _) => begin
        txt
      end
    end
  end
  return out_txt
end

function fun_145(
  in_txt::Tpl.Text,
  in_a_options::SCodeDump.SCodeDumpOptions,
  in_a_res::Tpl.Text,
)::Tpl.Text
  local out_txt::Tpl.Text

  @assign out_txt = begin
    local txt::Tpl.Text
    local a_res::Tpl.Text
    @match (in_txt, in_a_options, in_a_res) begin
      (txt, SCodeDump.OPTIONS(stripExternalDecl = false), a_res) => begin
        @assign txt = Tpl.writeText(txt, a_res)
        txt
      end

      (txt, _, _) => begin
        txt
      end
    end
  end
  return out_txt
end

function fun_146(
  in_txt::Tpl.Text,
  in_a_externalDecl::SCode.ExternalDecl,
  in_a_options::SCodeDump.SCodeDumpOptions,
  in_a_res::Tpl.Text,
)::Tpl.Text
  local out_txt::Tpl.Text

  @assign out_txt = begin
    local txt::Tpl.Text
    local a_options::SCodeDump.SCodeDumpOptions
    local a_res::Tpl.Text
    @match (in_txt, in_a_externalDecl, in_a_options, in_a_res) begin
      (txt, SCode.EXTERNALDECL(lang = SOME("builtin")), _, a_res) => begin
        @assign txt = Tpl.writeText(txt, a_res)
        txt
      end

      (txt, _, a_options, a_res) => begin
        @assign txt = fun_145(txt, a_options, a_res)
        txt
      end
    end
  end
  return out_txt
end

function dumpExternalDecl(
  txt::Tpl.Text,
  a_externalDecl::SCode.ExternalDecl,
  a_options::SCodeDump.SCodeDumpOptions,
)::Tpl.Text
  local out_txt::Tpl.Text

  local l_res::Tpl.Text

  @assign l_res = fun_144(Tpl.emptyTxt, a_externalDecl, a_options)
  @assign out_txt = fun_146(txt, a_externalDecl, a_options, l_res)
  return out_txt
end

function dumpCommentOpt(
  in_txt::Tpl.Text,
  in_a_comment::Option{<:SCode.Comment},
  in_a_options::SCodeDump.SCodeDumpOptions,
)::Tpl.Text
  local out_txt::Tpl.Text

  @assign out_txt = begin
    local txt::Tpl.Text
    local a_options::SCodeDump.SCodeDumpOptions
    local i_cmt::SCode.Comment
    @match (in_txt, in_a_comment, in_a_options) begin
      (txt, SOME(i_cmt), a_options) => begin
        @assign txt = dumpComment(txt, i_cmt, a_options)
        txt
      end

      (txt, _, _) => begin
        txt
      end
    end
  end
  return out_txt
end

function dumpComment(
  in_txt::Tpl.Text,
  in_a_comment::SCode.Comment,
  in_a_options::SCodeDump.SCodeDumpOptions,
)::Tpl.Text
  local out_txt::Tpl.Text

  @assign out_txt = begin
    local txt::Tpl.Text
    local a_options::SCodeDump.SCodeDumpOptions
    local i_comment::Option{String}
    local i_annotation__::Option{SCode.Annotation}
    local l_cmt__str::Tpl.Text
    local l_ann__str::Tpl.Text
    @match (in_txt, in_a_comment, in_a_options) begin
      (txt, SCode.COMMENT(annotation_ = i_annotation__, comment = i_comment), a_options) => begin
        @assign l_ann__str = dumpAnnotationOpt(Tpl.emptyTxt, i_annotation__, a_options)
        @assign l_cmt__str = dumpCommentStr(Tpl.emptyTxt, i_comment, a_options)
        @assign txt = Tpl.writeText(txt, l_cmt__str)
        @assign txt = Tpl.writeText(txt, l_ann__str)
        txt
      end

      (txt, _, _) => begin
        txt
      end
    end
  end
  return out_txt
end

function fun_150(in_txt::Tpl.Text, in_a_comment::Option{<:String})::Tpl.Text
  local out_txt::Tpl.Text

  @assign out_txt = begin
    local txt::Tpl.Text
    local i_cmt::String
    local ret_0::String
    @match (in_txt, in_a_comment) begin
      (txt, SOME(i_cmt)) => begin
        @assign txt = Tpl.writeTok(txt, Tpl.ST_STRING(" "))
        @assign txt = Tpl.writeTok(txt, Tpl.ST_STRING("\\"))
        @assign ret_0 = System.escapedString(i_cmt, false)
        @assign txt = Tpl.writeStr(txt, ret_0)
        @assign txt = Tpl.writeTok(txt, Tpl.ST_STRING("\\"))
        txt
      end

      (txt, _) => begin
        txt
      end
    end
  end
  return out_txt
end

function fun_151(
  in_txt::Tpl.Text,
  in_a_options::SCodeDump.SCodeDumpOptions,
  in_a_comment::Option{<:String},
)::Tpl.Text
  local out_txt::Tpl.Text

  @assign out_txt = begin
    local txt::Tpl.Text
    local a_comment::Option{String}
    @match (in_txt, in_a_options, in_a_comment) begin
      (txt, SCodeDump.OPTIONS(stripStringComments = false), a_comment) => begin
        @assign txt = fun_150(txt, a_comment)
        txt
      end

      (txt, _, _) => begin
        txt
      end
    end
  end
  return out_txt
end

function dumpCommentStr(
  txt::Tpl.Text,
  a_comment::Option{<:String},
  a_options::SCodeDump.SCodeDumpOptions,
)::Tpl.Text
  local out_txt::Tpl.Text

  @assign out_txt = fun_151(txt, a_options, a_comment)
  return out_txt
end

function errorMsg(txt::Tpl.Text, a_errMessage::String)::Tpl.Text
  local out_txt::Tpl.Text

  Tpl.addTemplateError(a_errMessage)
  @assign out_txt = Tpl.writeStr(txt, a_errMessage)
  return out_txt
end

@exportAll()
end
