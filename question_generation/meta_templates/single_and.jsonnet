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
      "How many <Z3> <C3> <M3> <S3>s are [both] <R2> the <Z2> <C2> <M2> <S2> and <R> the <Z> <C> <M> <S>?",
      "What number of <Z3> <C3> <M3> <S3>s are [both] <R2> the <Z2> <C2> <M2> <S2> and <R> the <Z> <C> <M> <S>?"
    ],
    "query": [
      "MATCH (i)~[:contains]~~<o<S>{<Z><C><M>}>,",
      "(i)~[:contains]~~<o2<S2>{<Z2><C2><M2>}>,",
      "(i)~[:contains]~~<o3<S3>{<Z3><C3><M3>}>,",
      "<o3>~~[<R2>]~<o2>, <o3>~~[<R>]~<o>",
      "RETURN count(o3) as count"],
    "nodes": [
      nodes.scene,
      nodes.filter_unique(),
      nodes.relate('', [1]),
      nodes.scene,
      nodes.filter_unique(2, [3]),
      nodes.relate('2', [4]),
      nodes.intersect([2,5]),
      nodes.filter_count(3, [6])
    ],
    "params": params_types.ororo,
    "constraints": []
  },
  {
    "text": [
      "What is the size of the <Z3> <C3> <M3> <S3> that is [both] <R2> the <Z2> <C2> <M2> <S2> and <R> the <Z> <C> <M> <S>?",
      "What size is the <Z3> <C3> <M3> <S3> that is [both] <R2> the <Z2> <C2> <M2> <S2> and <R> the <Z> <C> <M> <S>?",
      "How big is the <Z3> <C3> <M3> <S3> that is [both] <R2> the <Z2> <C2> <M2> <S2> and <R> the <Z> <C> <M> <S>?",
      "There is a <Z3> <C3> <M3> <S3> that is [both] <R2> the <Z2> <C2> <M2> <S2> and <R> the <Z> <C> <M> <S>; what is its size?",
      "There is a <Z3> <C3> <M3> <S3> that is [both] <R2> the <Z2> <C2> <M2> <S2> and <R> the <Z> <C> <M> <S>; what size is it?",
      "There is a <Z3> <C3> <M3> <S3> that is [both] <R2> the <Z2> <C2> <M2> <S2> and <R> the <Z> <C> <M> <S>; how big is it?"
    ],
    "query": [
      "MATCH (i)~[:contains]~~<o<S>{<Z><C><M>}>,",
      "(i)~[:contains]~~<o2<S2>{<Z2><C2><M2>}>,",
      "(i)~[:contains]~~<o3<S3>{<Z3><C3><M3>}>,",
      "<o3>~~[<R2>]~<o2>, <o3>~~[<R>]~<o>",
      "RETURN o3.size as size"],
    "nodes": [
      nodes.scene,
      nodes.filter_unique(),
      nodes.relate('', [1]),
      nodes.scene,
      nodes.filter_unique(2, [3]),
      nodes.relate('2', [4]),
      nodes.intersect([2,5]),
      nodes.filter_unique(3, [6]),
      nodes.query_size([7])
    ],
    "params": params_types.ororo,
    "constraints": [
      nodes.out_neq([2,5]),
      nodes.null_z(3)
    ]
  },
  {
    "text": [
      "What is the color of the <Z3> <C3> <M3> <S3> that is [both] <R2> the <Z2> <C2> <M2> <S2> and <R> the <Z> <C> <M> <S>?",
      "What color is the <Z3> <C3> <M3> <S3> that is [both] <R2> the <Z2> <C2> <M2> <S2> and <R> the <Z> <C> <M> <S>?",
      "The <Z3> <C3> <M3> <S3> that is [both] <R2> the <Z2> <C2> <M2> <S2> and <R> the <Z> <C> <M> <S> is what color?",
      "There is a <Z3> <C3> <M3> <S3> that is [both] <R2> the <Z2> <C2> <M2> <S2> and <R> the <Z> <C> <M> <S>; what is its color?",
      "There is a <Z3> <C3> <M3> <S3> that is [both] <R2> the <Z2> <C2> <M2> <S2> and <R> the <Z> <C> <M> <S>; what color is it?"
    ],
    "query": [
      "MATCH (i)~[:contains]~~<o<S>{<Z><C><M>}>,",
      "(i)~[:contains]~~<o2<S2>{<Z2><C2><M2>}>,",
      "(i)~[:contains]~~<o3<S3>{<Z3><C3><M3>}>,",
      "<o3>~~[<R2>]~<o2>, <o3>~~[<R>]~<o>",
      "RETURN o3.color as color"],
    "nodes": [
      nodes.scene,
      nodes.filter_unique(),
      nodes.relate('', [1]),
      nodes.scene,
      nodes.filter_unique(2, [3]),
      nodes.relate('2', [4]),
      nodes.intersect([2,5]),
      nodes.filter_unique(3, [6]),
      nodes.query_color([7])
    ],
    "params": params_types.all_props() + params_types.r() + params_types.all_props(2) + 
params_types.r(2) +params_types.all_props(3),
    "constraints": [
      nodes.null_c(3),
      nodes.out_neq([2,5])
    ]
  },
  {
    "text": [
      "What is the material of the <Z3> <C3> <M3> <S3> that is [both] <R2> the <Z2> <C2> <M2> <S2> and <R> the <Z> <C> <M> <S>?",
      "What material is the <Z3> <C3> <M3> <S3> that is [both] <R2> the <Z2> <C2> <M2> <S2> and <R> the <Z> <C> <M> <S>?",
      "What is the <Z3> <C3> <M3> <S3> that is [both] <R2> the <Z2> <C2> <M2> <S2> and <R> the <Z> <C> <M> <S> made of?",
      "The <Z3> <C3> <M3> <S3> that is [both] <R2> the <Z2> <C2> <M2> <S2> and <R> the <Z> <C> <M> <S> is made of what material?",
      "There is a <Z3> <C3> <M3> <S3> that is [both] <R2> the <Z2> <C2> <M2> <S2> and <R> the <Z> <C> <M> <S>; what is its material?",
      "There is a <Z3> <C3> <M3> <S3> that is [both] <R2> the <Z2> <C2> <M2> <S2> and <R> the <Z> <C> <M> <S>; what material is it?",
      "There is a <Z3> <C3> <M3> <S3> that is [both] <R2> the <Z2> <C2> <M2> <S2> and <R> the <Z> <C> <M> <S>; what [material] is it made of?"
    ],
    "query": [
      "MATCH (i)~[:contains]~~<o<S>{<Z><C><M>}>,",
      "(i)~[:contains]~~<o2<S2>{<Z2><C2><M2>}>,",
      "(i)~[:contains]~~<o3<S3>{<Z3><C3><M3>}>,",
      "<o3>~~[<R2>]~<o2>, <o3>~~[<R>]~<o>",
      "RETURN o3.material as material"],
    "nodes": [
      nodes.scene,
      nodes.filter_unique(),
      nodes.relate('', [1]),
      nodes.scene,
      nodes.filter_unique(2, [3]),
      nodes.relate('2', [4]),
      nodes.intersect([2,5]),
      nodes.filter_unique(3, [6]),
      nodes.query_material([7])
    ],
    "params": params_types.all_props() + params_types.r() + params_types.all_props(2) + 
params_types.r(2) +params_types.all_props(3),
    "constraints": [
      nodes.out_neq([2,5]),
      nodes.null_m(3)
    ]
  },
  {
    "text": [
      "What is the shape of the <Z3> <C3> <M3> <S3> that is [both] <R2> the <Z2> <C2> <M2> <S2> and <R> the <Z> <C> <M> <S>?",
      "What shape is the <Z3> <C3> <M3> <S3> that is [both] <R2> the <Z2> <C2> <M2> <S2> and <R> the <Z> <C> <M> <S>?",
      "The <Z3> <C3> <M3> <S3> that is [both] <R2> the <Z2> <C2> <M2> <S2> and <R> the <Z> <C> <M> <S> has what shape?",
      "There is a <Z3> <C3> <M3> <S3> that is [both] <R2> the <Z2> <C2> <M2> <S2> and <R> the <Z> <C> <M> <S>; what shape is it?",
      "There is a <Z3> <C3> <M3> <S3> that is [both] <R2> the <Z2> <C2> <M2> <S2> and <R> the <Z> <C> <M> <S>; what is its shape?"
    ],
    "query": [
      "MATCH (i)~[:contains]~~<o<S>{<Z><C><M>}>,",
      "(i)~[:contains]~~<o2<S2>{<Z2><C2><M2>}>,",
      "(i)~[:contains]~~<o3<S3>{<Z3><C3><M3>}>,",
      "<o3>~~[<R2>]~<o2>, <o3>~~[<R>]~<o>",
      "RETURN labels(o3)[0] as shape"],
    "nodes": [
      nodes.scene,
      nodes.filter_unique(),
      nodes.relate('', [1]),
      nodes.scene,
      nodes.filter_unique(2, [3]),
      nodes.relate('2', [4]),
      nodes.intersect([2,5]),
      nodes.filter_unique(3, [6]),
      nodes.query_shape([7])
    ],
    "params": params_types.all_props() + params_types.r() + params_types.all_props(2) + 
params_types.r(2) +params_types.all_props(3),
    "constraints": [
      nodes.out_neq([2,5]),
      nodes.null_s(3)
    ]
  }
]