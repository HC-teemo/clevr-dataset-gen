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
      "How many <Z3> <C3> <M3> <S3>s are <R2> the <Z2> <C2> <M2> <S2> [that is] <R> the <Z> <C> <M> <S>?",
      "What number of <Z3> <C3> <M3> <S3>s are <R2> the <Z2> <C2> <M2> <S2> [that is] <R> the <Z> <C> <M> <S>?",
      "There is a <Z2> <C2> <M2> <S2> [that is] <R> the <Z> <C> <M> <S>; how many <Z3> <C3> <M3> <S3>s are <R2> it?",
      "There is a <Z2> <C2> <M2> <S2> [that is] <R> the <Z> <C> <M> <S>; what number of <Z3> <C3> <M3> <S3>s are <R2> it?"
    ],
    "nodes": [
      nodes.scene,
      nodes.filter_unique(),
      nodes.relate_filter_unique(2,'',[1]),
      nodes.relate_filter_count(3,'2', [2])
    ],
    "params": params_types.all_props() + params_types.r() + params_types.all_props(2) + 
params_types.r(2) +params_types.all_props(3),
    "constraints": []
  },
  {
    "text": [
      "Are there any <Z3> <C3> <M3> <S3>s [that are] <R2> the <Z2> <C2> <M2> <S2> [that is] <R> the <Z> <C> <M> <S>?",
      "Is there a <Z3> <C3> <M3> <S3> [that is] <R2> the <Z2> <C2> <M2> <S2> [that is] <R> the <Z> <C> <M> <S>?",
      "There is a <Z2> <C2> <M2> <S2> [that is] <R> the <Z> <C> <M> <S>; are there any <Z3> <C3> <M3> <S3>s [that are] <R2> it?",
      "There is a <Z2> <C2> <M2> <S2> [that is] <R> the <Z> <C> <M> <S>; is there a <Z3> <C3> <M3> <S3> [that is] <R2> it?"
    ],
    "nodes": [
      nodes.scene,
      nodes.filter_unique(),
      nodes.relate_filter_unique(2,'',[1]),
      nodes.relate_filter_exist(3,'2', [2])
    ],
    "params": params_types.all_props() + params_types.r() + params_types.all_props(2) + 
params_types.r(2) +params_types.all_props(3),
    "constraints": []
  },
  {
    "text": [
      "What size is the <Z3> <C3> <M3> <S3> [that is] <R2> the <Z2> <C2> <M2> <S2> [that is] <R> the <Z> <C> <M> <S>?",
      "What is the size of the <Z3> <C3> <M3> <S3> [that is] <R2> the <Z2> <C2> <M2> <S2> [that is] <R> the <Z> <C> <M> <S>?",
      "How big is the <Z3> <C3> <M3> <S3> [that is] <R2> the <Z2> <C2> <M2> <S2> [that is] <R> the <Z> <C> <M> <S>?",
      "There is a <Z3> <C3> <M3> <S3> [that is] <R2> the <Z2> <C2> <M2> <S2> [that is] <R> the <Z> <C> <M> <S>; what size is it?",
      "There is a <Z3> <C3> <M3> <S3> [that is] <R2> the <Z2> <C2> <M2> <S2> [that is] <R> the <Z> <C> <M> <S>; what is its size?",
      "There is a <Z3> <C3> <M3> <S3> [that is] <R2> the <Z2> <C2> <M2> <S2> [that is] <R> the <Z> <C> <M> <S>; how big is it?"
    ],
    "nodes": [
      nodes.scene,
      nodes.filter_unique(),
      nodes.relate_filter_unique(2,'',[1]),
      nodes.relate_filter_unique(3,'2', [2]),
      nodes.query_size([3])
    ],
    "params": params_types.all_props() + params_types.r() + params_types.all_props(2) + 
params_types.r(2) +params_types.all_props(3),
    "constraints": [
      nodes.null_z(3)
    ]
  },
  {
    "text": [
      "What color is the <Z3> <C3> <M3> <S3> [that is] <R2> the <Z2> <C2> <M2> <S2> [that is] <R> the <Z> <C> <M> <S>?",
      "What is the color of the <Z3> <C3> <M3> <S3> [that is] <R2> the <Z2> <C2> <M2> <S2> [that is] <R> the <Z> <C> <M> <S>?",
      "The <Z3> <C3> <M3> <S3> [that is] <R2> the <Z2> <C2> <M2> <S2> [that is] <R> the <Z> <C> <M> <S> is what color?",
      "There is a <Z3> <C3> <M3> <S3> [that is] <R2> the <Z2> <C2> <M2> <S2> [that is] <R> the <Z> <C> <M> <S>; what color is it?",
      "There is a <Z3> <C3> <M3> <S3> [that is] <R2> the <Z2> <C2> <M2> <S2> [that is] <R> the <Z> <C> <M> <S>; what is its color?"
    ],
    "nodes": [
      nodes.scene,
      nodes.filter_unique(),
      nodes.relate_filter_unique(2,'',[1]),
      nodes.relate_filter_unique(3,'2', [2]),
      nodes.query_color([3])
    ],
    "params": params_types.all_props() + params_types.r() + params_types.all_props(2) + 
params_types.r(2) +params_types.all_props(3),
    "constraints": [
      nodes.null_c(3)
    ]
  },
  {
    "text": [
      "What material is the <Z3> <C3> <M3> <S3> [that is] <R2> the <Z2> <C2> <M2> <S2> [that is] <R> the <Z> <C> <M> <S>?",
      "What is the material of the <Z3> <C3> <M3> <S3> [that is] <R2> the <Z2> <C2> <M2> <S2> [that is] <R> the <Z> <C> <M> <S>?",
      "The <Z3> <C3> <M3> <S3> [that is] <R2> the <Z2> <C2> <M2> <S2> [that is] <R> the <Z> <C> <M> <S> is made of what material?",
      "There is a <Z3> <C3> <M3> <S3> [that is] <R2> the <Z2> <C2> <M2> <S2> [that is] <R> the <Z> <C> <M> <S>; what is its material?",
      "There is a <Z3> <C3> <M3> <S3> [that is] <R2> the <Z2> <C2> <M2> <S2> [that is] <R> the <Z> <C> <M> <S>; what is it made of?",
      "What [material] is the <Z3> <C3> <M3> <S3> [that is] <R2> the <Z2> <C2> <M2> <S2> [that is] <R> the <Z> <C> <M> <S> made of?"
    ],
    "nodes": [
      nodes.scene,
      nodes.filter_unique(),
      nodes.relate_filter_unique(2,'',[1]),
      nodes.relate_filter_unique(3,'2', [2]),
      nodes.query_material([3])
    ],
    "params": params_types.all_props() + params_types.r() + params_types.all_props(2) + 
params_types.r(2) +params_types.all_props(3),
    "constraints": [
      nodes.null_m(3)
    ]
  },
  {
    "text": [
      "What shape is the <Z3> <C3> <M3> <S3> [that is] <R2> the <Z2> <C2> <M2> <S2> [that is] <R> the <Z> <C> <M> <S>?",
      "What is the shape of the <Z3> <C3> <M3> <S3> [that is] <R2> the <Z2> <C2> <M2> <S2> [that is] <R> the <Z> <C> <M> <S>?",
      "The <Z3> <C3> <M3> <S3> [that is] <R2> the <Z2> <C2> <M2> <S2> [that is] <R> the <Z> <C> <M> <S> is what shape?",
      "There is a <Z3> <C3> <M3> <S3> [that is] <R2> the <Z2> <C2> <M2> <S2> [that is] <R> the <Z> <C> <M> <S>; what shape is it?",
      "There is a <Z3> <C3> <M3> <S3> [that is] <R2> the <Z2> <C2> <M2> <S2> [that is] <R> the <Z> <C> <M> <S>; what is its shape?"
    ],
    "nodes": [
      nodes.scene,
      nodes.filter_unique(),
      nodes.relate_filter_unique(2,'',[1]),
      nodes.relate_filter_unique(3,'2', [2]),
      nodes.query_shape([3])
    ],
    "params": params_types.all_props() + params_types.r() + params_types.all_props(2) + 
params_types.r(2) +params_types.all_props(3),
    "constraints": [
      nodes.null_s(3)
    ]
  }
]