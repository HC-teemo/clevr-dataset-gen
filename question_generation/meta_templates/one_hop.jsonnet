local meta = import 'meta.libsonnet';
local nodes = import 'nodes.libsonnet';

local params_types = meta.params_types;
local frags = meta.query_frags;
local _ = meta.query_funcs;
local i = 'i';
local obs = 'objects';
local o= 'o';
local o2= 'o2';
local o3= 'o3';
local o4= 'o4';
local r = '[<R>]';
local r2 = '[<R2>]';

[
  {
    "text": [
      "What number of <Z2> <C2> <M2> <S2>s are <R> the <Z> <C> <M> <S>?",
      "How many <Z2> <C2> <M2> <S2>s are <R> the <Z> <C> <M> <S>?",
      "There is a <Z> <C> <M> <S>; how many <Z2> <C2> <M2> <S2>s are <R> it?",
      "There is a <Z> <C> <M> <S>; what number of <Z2> <C2> <M2> <S2>s are <R> it?"
    ],
    "query": [
      "MATCH (i)~[:contains]~~<o<S>{<Z><C><M>}>,",
      "(i)~[:contains]~~<o2<S2>{<Z2><C2><M2>}>~~[<R>]~<o>",
      "RETURN count(o2) as count"],
    "nodes": [
      nodes.scene,
      nodes.filter_unique(),
      nodes.relate_filter_count(2,'',[1])
    ],
    "params": params_types.all_props() + 
params_types.r() +params_types.all_props(2),
    "constraints": []
  },
  {
    "text": [
      "Are there any <Z2> <C2> <M2> <S2>s <R> the <Z> <C> <M> <S>?",
      "There is a <Z> <C> <M> <S>; are there any <Z2> <C2> <M2> <S2>s <R> it?"
    ],
    "query": [
      "MATCH (i)~[:contains]~~<o<S>{<Z><C><M>}>,",
      "(i)~[:contains]~~<o2<S2>{<Z2><C2><M2>}>~~[<R>]~<o>",
      "WITH o2 LIMIT 1",
      "RETURN count(o2)>0 as exist"],
    "nodes": [
      nodes.scene,
      nodes.filter_unique(),
      nodes.relate_filter_exist(2,'', [1])
    ],
    "params": params_types.all_props() + 
params_types.r() +params_types.all_props(2),
    "constraints": []
  },
  {
    "text": [
      "What size is the <Z2> <C2> <M2> <S2> [that is] <R> the <Z> <C> <M> <S>?",
      "What is the size of the <Z2> <C2> <M2> <S2> [that is] <R> the <Z> <C> <M> <S>?",
      "How big is the <Z2> <C2> <M2> <S2> [that is] <R> the <Z> <C> <M> <S>?",
      "There is a <Z2> <C2> <M2> <S2> [that is] <R> the <Z> <C> <M> <S>; what size is it?",
      "There is a <Z2> <C2> <M2> <S2> [that is] <R> the <Z> <C> <M> <S>; how big is it?",
      "There is a <Z2> <C2> <M2> <S2> [that is] <R> the <Z> <C> <M> <S>; what is its size?"
    ],
    "query": [
      "MATCH (i)~[:contains]~~<o<S>{<Z><C><M>}>,",
      "(i)~[:contains]~~<o2<S2>{<Z2><C2><M2>}>~~[<R>]~<o>",
      "RETURN o2.size as size"],
    "nodes": [
      nodes.scene,
      nodes.filter_unique(),
      nodes.relate_filter_unique(2,'',[1]),
      nodes.query_size([2])
    ],
    "params": params_types.all_props() + 
params_types.r() +params_types.all_props(2),
    "constraints": [
      nodes.null_z(2)
    ]
  },
  {
    "text": [
      "What color is the <Z2> <C2> <M2> <S2> [that is] <R> the <Z> <C> <M> <S>?",
      "What is the color of the <Z2> <C2> <M2> <S2> [that is] <R> the <Z> <C> <M> <S>?",
      "The <Z2> <C2> <M2> <S2> [that is] <R> the <Z> <C> <M> <S> is what color?",
      "There is a <Z2> <C2> <M2> <S2> [that is] <R> the <Z> <C> <M> <S>; what color is it?",
      "There is a <Z2> <C2> <M2> <S2> [that is] <R> the <Z> <C> <M> <S>; what is its color?"
    ],
    "query": [
      "MATCH (i)~[:contains]~~<o<S>{<Z><C><M>}>,",
      "(i)~[:contains]~~<o2<S2>{<Z2><C2><M2>}>~~[<R>]~<o>",
      "RETURN o2.color as color"],
    "nodes": [
      nodes.scene,
      nodes.filter_unique(),
      nodes.relate_filter_unique(2,'',[1]),
      nodes.query_color([2])
    ],
    "params": params_types.all_props() + 
params_types.r() +params_types.all_props(2),
    "constraints": [
      nodes.null_c(2)
    ]
  },
  {
    "text": [
      "What is the material of the <Z2> <C2> <M2> <S2> [that is] <R> the <Z> <C> <M> <S>?",
      "What material is the <Z2> <C2> <M2> <S2> [that is] <R> the <Z> <C> <M> <S>?",
      "What is the <Z2> <C2> <M2> <S2> [that is] <R> the <Z> <C> <M> <S> made of?",
      "There is a <Z2> <C2> <M2> <S2> [that is] <R> the <Z> <C> <M> <S>; what is its material?",
      "There is a <Z2> <C2> <M2> <S2> [that is] <R> the <Z> <C> <M> <S>; what material is it?",
      "There is a <Z2> <C2> <M2> <S2> [that is] <R> the <Z> <C> <M> <S>; what is it made of?"
    ],
    "query": [
      "MATCH (i)~[:contains]~~<o<S>{<Z><C><M>}>,",
      "(i)~[:contains]~~<o2<S2>{<Z2><C2><M2>}>~~[<R>]~<o>",
      "RETURN o2.material as material"],
    "nodes": [
      nodes.scene,
      nodes.filter_unique(),
      nodes.relate_filter_unique(2,'',[1]),
      nodes.query_material([2])
    ],
    "params": params_types.all_props() + 
params_types.r() +params_types.all_props(2),
    "constraints": [
      nodes.null_m(2)
    ]
  },
  {
    "text": [
      "What shape is the <Z2> <C2> <M2> <S2> [that is] <R> the <Z> <C> <M> <S>?",
      "What is the shape of the <Z2> <C2> <M2> <S2> [that is] <R> the <Z> <C> <M> <S>?",
      "The <Z2> <C2> <M2> <S2> [that is] <R> the <Z> <C> <M> <S> has what shape?",
      "There is a <Z2> <C2> <M2> <S2> [that is] <R> the <Z> <C> <M> <S>; what is its shape?",
      "There is a <Z2> <C2> <M2> <S2> [that is] <R> the <Z> <C> <M> <S>; what shape is it?"
    ],
    "query": [
      "MATCH (i)~[:contains]~~<o<S>{<Z><C><M>}>,",
      "(i)~[:contains]~~<o2<S2>{<Z2><C2><M2>}>~~[<R>]~<o>",
      "RETURN labels(o2)[0] as shape"],
    "nodes": [
      nodes.scene,
      nodes.filter_unique(),
      nodes.relate_filter_unique(2,'',[1]),
      nodes.query_shape([2])
    ],
    "params": params_types.all_props() + 
params_types.r() +params_types.all_props(2),
    "constraints": [
      nodes.null_s(2)
    ]
  }
]