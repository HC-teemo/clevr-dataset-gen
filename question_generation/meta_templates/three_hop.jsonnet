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
local r3 = '[<R3>]';

local fragement1 = frags.match_all_and + _.match + frags.obj_r_obj(o, r, o2) + frags.r_obj(r2, o3) + frags.r_obj(r3, o4) + frags.where_in_obs([o,o2,o3,o4]);

[
  {
    "text": [
      "How many <Z4> <C4> <M4> <S4>s are <R3> the <Z3> <C3> <M3> <S3> [that is] <R2> the <Z2> <C2> <M2> <S2> [that is] <R> the <Z> <C> <M> <S>?",
      "What number of <Z4> <C4> <M4> <S4>s are <R3> the <Z3> <C3> <M3> <S3> [that is] <R2> the <Z2> <C2> <M2> <S2> [that is] <R> the <Z> <C> <M> <S>?",
      "There is a <Z3> <C3> <M3> <S3> [that is] <R2> the <Z2> <C2> <M2> <S2> [that is] <R> the <Z> <C> <M> <S>; how many <Z4> <C4> <M4> <S4>s are <R3> it?",
      "There is a <Z3> <C3> <M3> <S3> [that is] <R2> the <Z2> <C2> <M2> <S2> [that is] <R> the <Z> <C> <M> <S>; what number of <Z4> <C4> <M4> <S4>s are <R3> it?"
    ],
    "query": fragement1+frags.return_count(o4),
    "nodes": [
      nodes.scene,
      nodes.filter_unique(),
      nodes.relate_filter_unique(2,'',[1]),
      nodes.relate_filter_unique(3,'2', [2]),
      nodes.relate_filter_count(4,'3', [3])
    ],
    "params": params_types.all_props() + params_types.r() + params_types.all_props(2) + 
params_types.r(2) +params_types.all_props(3) + params_types.r(3) +params_types.all_props(4),
    "constraints": []
  },
  {
    "text": [
      "Are there any <Z4> <C4> <M4> <S4>s [that are] <R3> the <Z3> <C3> <M3> <S3> [that is] <R2> the <Z2> <C2> <M2> <S2> [that is] <R> the <Z> <C> <M> <S>?",
      "Is there a <Z4> <C4> <M4> <S4> [that is] <R3> the <Z3> <C3> <M3> <S3> [that is] <R2> the <Z2> <C2> <M2> <S2> [that is] <R> the <Z> <C> <M> <S>?",
      "There is a <Z3> <C3> <M3> <S3> [that is] <R2> the <Z2> <C2> <M2> <S2> [that is] <R> the <Z> <C> <M> <S>; are there any <Z4> <C4> <M4> <S4>s [that are] <R3> it?",
      "There is a <Z3> <C3> <M3> <S3> [that is] <R2> the <Z2> <C2> <M2> <S2> [that is] <R> the <Z> <C> <M> <S>; is there a <Z4> <C4> <M4> <S4> [that is] <R3> it?"
    ],
    "query": fragement1+frags.exist(o4),
    "nodes": [
      nodes.scene,
      nodes.filter_unique(),
      nodes.relate_filter_unique(2,'',[1]),
      nodes.relate_filter_unique(3,'2', [2]),
      nodes.relate_filter_exist(4,'3', [3])
    ],
    "params": params_types.all_props() + params_types.r() + params_types.all_props(2) + 
params_types.r(2) +params_types.all_props(3) + params_types.r(3) +params_types.all_props(4),
    "constraints": []
  },
  {
    "text": [
      "What size is the <Z4> <C4> <M4> <S4> [that is] <R3> the <Z3> <C3> <M3> <S3> [that is] <R2> the <Z2> <C2> <M2> <S2> [that is] <R> the <Z> <C> <M> <S>?",
      "What is the size of the <Z4> <C4> <M4> <S4> [that is] <R3> the <Z3> <C3> <M3> <S3> [that is] <R2> the <Z2> <C2> <M2> <S2> [that is] <R> the <Z> <C> <M> <S>?",
      "How big is the <Z4> <C4> <M4> <S4> [that is] <R3> the <Z3> <C3> <M3> <S3> [that is] <R2> the <Z2> <C2> <M2> <S2> [that is] <R> the <Z> <C> <M> <S>?",
      "There is a <Z4> <C4> <M4> <S4> [that is] <R3> the <Z3> <C3> <M3> <S3> [that is] <R2> the <Z2> <C2> <M2> <S2> [that is] <R> the <Z> <C> <M> <S>; what size is it?",
      "There is a <Z4> <C4> <M4> <S4> [that is] <R3> the <Z3> <C3> <M3> <S3> [that is] <R2> the <Z2> <C2> <M2> <S2> [that is] <R> the <Z> <C> <M> <S>; what is its size?",
      "There is a <Z4> <C4> <M4> <S4> [that is] <R3> the <Z3> <C3> <M3> <S3> [that is] <R2> the <Z2> <C2> <M2> <S2> [that is] <R> the <Z> <C> <M> <S>; how big is it?"
    ],
    "query": fragement1+frags.return_size(o4),
    "nodes": [
      nodes.scene,
      nodes.filter_unique(),
      nodes.relate_filter_unique(2,'',[1]),
      nodes.relate_filter_unique(3,'2', [2]),
      nodes.relate_filter_unique(4,'3', [3]),
      nodes.query_size([4])
    ],
    "params": params_types.all_props() + params_types.r() + params_types.all_props(2) + 
params_types.r(2) +params_types.all_props(3) + params_types.r(3) +params_types.all_props(4),
    "constraints": [
      nodes.null_z(4)
    ]
  },
  {
    "text": [
      "What shape is the <Z4> <C4> <M4> <S4> [that is] <R3> the <Z3> <C3> <M3> <S3> [that is] <R2> the <Z2> <C2> <M2> <S2> [that is] <R> the <Z> <C> <M> <S>?",
      "What is the shape of the <Z4> <C4> <M4> <S4> [that is] <R3> the <Z3> <C3> <M3> <S3> [that is] <R2> the <Z2> <C2> <M2> <S2> [that is] <R> the <Z> <C> <M> <S>?",
      "The <Z4> <C4> <M4> <S4> [that is] <R3> the <Z3> <C3> <M3> <S3> [that is] <R2> the <Z2> <C2> <M2> <S2> [that is] <R> the <Z> <C> <M> <S> is what shape?",
      "There is a <Z4> <C4> <M4> <S4> [that is] <R3> the <Z3> <C3> <M3> <S3> [that is] <R2> the <Z2> <C2> <M2> <S2> [that is] <R> the <Z> <C> <M> <S>; what shape is it?",
      "There is a <Z4> <C4> <M4> <S4> [that is] <R3> the <Z3> <C3> <M3> <S3> [that is] <R2> the <Z2> <C2> <M2> <S2> [that is] <R> the <Z> <C> <M> <S>; what is its shape?"
    ],
    "query": fragement1+frags.return_shape(o4),
    "nodes": [
      nodes.scene,
      nodes.filter_unique(),
      nodes.relate_filter_unique(2,'',[1]),
      nodes.relate_filter_unique(3,'2', [2]),
      nodes.relate_filter_unique(4,'3', [3]),
      nodes.query_shape([4])
    ],
    "params": params_types.all_props() + params_types.r() + params_types.all_props(2) + 
params_types.r(2) +params_types.all_props(3) + params_types.r(3) +params_types.all_props(4),
    "constraints": [
      nodes.null_s(4)
    ]
  },
  {
    "text": [
      "What color is the <Z4> <C4> <M4> <S4> [that is] <R3> the <Z3> <C3> <M3> <S3> [that is] <R2> the <Z2> <C2> <M2> <S2> [that is] <R> the <Z> <C> <M> <S>?",
      "What is the color of the <Z4> <C4> <M4> <S4> [that is] <R3> the <Z3> <C3> <M3> <S3> [that is] <R2> the <Z2> <C2> <M2> <S2> [that is] <R> the <Z> <C> <M> <S>?",
      "The <Z4> <C4> <M4> <S4> [that is] <R3> the <Z3> <C3> <M3> <S3> [that is] <R2> the <Z2> <C2> <M2> <S2> [that is] <R> the <Z> <C> <M> <S> is what color?",
      "There is a <Z4> <C4> <M4> <S4> [that is] <R3> the <Z3> <C3> <M3> <S3> [that is] <R2> the <Z2> <C2> <M2> <S2> [that is] <R> the <Z> <C> <M> <S>; what color is it?",
      "There is a <Z4> <C4> <M4> <S4> [that is] <R3> the <Z3> <C3> <M3> <S3> [that is] <R2> the <Z2> <C2> <M2> <S2> [that is] <R> the <Z> <C> <M> <S>; what is its color?"
    ],
    "query": fragement1+frags.return_color(o4),
    "nodes": [
      nodes.scene,
      nodes.filter_unique(),
      nodes.relate_filter_unique(2,'',[1]),
      nodes.relate_filter_unique(3,'2', [2]),
      nodes.relate_filter_unique(4,'3', [3]),
      nodes.query_color([4])
    ],
    "params": params_types.all_props() + params_types.r() + params_types.all_props(2) + 
params_types.r(2) +params_types.all_props(3) + params_types.r(3) +params_types.all_props(4),
    "constraints": [
      nodes.null_c(4)
    ]
  },
  {
    "text": [
      "What material is the <Z4> <C4> <M4> <S4> [that is] <R3> the <Z3> <C3> <M3> <S3> [that is] <R2> the <Z2> <C2> <M2> <S2> [that is] <R> the <Z> <C> <M> <S>?",
      "What is the material of the <Z4> <C4> <M4> <S4> [that is] <R3> the <Z3> <C3> <M3> <S3> [that is] <R2> the <Z2> <C2> <M2> <S2> [that is] <R> the <Z> <C> <M> <S>?",
      "The <Z4> <C4> <M4> <S4> [that is] <R3> the <Z3> <C3> <M3> <S3> [that is] <R2> the <Z2> <C2> <M2> <S2> [that is] <R> the <Z> <C> <M> <S> is made of what material?",
      "There is a <Z4> <C4> <M4> <S4> [that is] <R3> the <Z3> <C3> <M3> <S3> [that is] <R2> the <Z2> <C2> <M2> <S2> [that is] <R> the <Z> <C> <M> <S>; what is its material?",
      "There is a <Z4> <C4> <M4> <S4> [that is] <R3> the <Z3> <C3> <M3> <S3> [that is] <R2> the <Z2> <C2> <M2> <S2> [that is] <R> the <Z> <C> <M> <S>; what is it made of?",
      "What [material] is the <Z4> <C4> <M4> <S4> [that is] <R3> the <Z3> <C3> <M3> <S3> [that is] <R2> the <Z2> <C2> <M2> <S2> [that is] <R> the <Z> <C> <M> <S> made of?"
    ],
    "query": fragement1+frags.return_material(o4),
    "nodes": [
      nodes.scene,
      nodes.filter_unique(),
      nodes.relate_filter_unique(2,'',[1]),
      nodes.relate_filter_unique(3,'2', [2]),
      nodes.relate_filter_unique(4,'3', [3]),
      nodes.query_material([4])
    ],
    "params": params_types.all_props() + params_types.r() + params_types.all_props(2) + 
params_types.r(2) +params_types.all_props(3) + params_types.r(3) +params_types.all_props(4),
    "constraints": [
      nodes.null_m(4)
    ]
  }
]