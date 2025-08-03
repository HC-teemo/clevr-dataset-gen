local meta = import 'meta.libsonnet';
local nodes = import 'nodes.libsonnet';

local params_types = meta.params_types;
local frags = meta.query_frags;
local funcs = meta.query_funcs;

local o= 'o';
local o2= 'o2';
local o3= 'o3';
local o4= 'o4';


[
  {
    "text": [
      "How many <Z> <C> <M> <S>s are there?",
      "What number of <Z> <C> <M> <S>s are there?"
    ],
    "query": frags.match_filter(o) + frags.return_count(o),
    "nodes": [
      nodes.scene, 
      nodes.filter_count()
    ],
    "params": params_types.all_props(),
    "constraints": []
  },
  {
    "text": [
      "Are there any <Z> <C> <M> <S>s?",
      "Are any <Z> <C> <M> <S>s visible?",
      "Is there a <Z> <C> <M> <S>?"
    ],
    "query": frags.match_filter(o) + frags.exist(o),
    "query2": "MATCH (i)~[:contains]~~<o<S>{<Z><C><M>}> WITH o LIMIT 1 RETURN count(o) > 0 as exist",
    "nodes": [
      nodes.scene, 
      nodes.filter_exist()
    ],
    "params": params_types.all_props(),
    "constraints": []
  },
  {
    "text": [
      "What shape is the <Z> <C> <M> <S>?",
      "What is the shape of the <Z> <C> <M> <S>?",
      "The <Z> <C> <M> <S> has what shape?",
      "What is the shape of the <Z> <C> <M> <S>?",
      "There is a <Z> <C> <M> <S>; what shape is it?",
      "The <Z> <C> <M> <S> is what shape?"
    ],
    "query": frags.match_filter(o) + frags.return_shape(o),
    "query2": "MATCH (i)~[:contains]~~<o<S>{<Z><C><M>}> RETURN labels(o)[0] as shape",
    "nodes": [
      nodes.scene, 
      nodes.filter_unique(), 
      nodes.query_shape()
    ],
    "params": params_types.all_props(),
    "constraints": [
      nodes.null_s()
    ]
  },
  {
    "text": [
      "What material is the <Z> <C> <M> <S>?",
      "What is the material of the <Z> <C> <M> <S>?",
      "What is the <Z> <C> <M> <S> made of?"
    ],
    "query": frags.match_filter(o) + frags.return_material(o),
    "query2": "MATCH (i)~[:contains]~~<o<S>{<Z><C><M>}> RETURN o.material as material",
    "nodes": [
      nodes.scene,
      nodes.filter_unique(),
      nodes.query_material()
    ],
    "params": params_types.all_props(),
    "constraints": [
      nodes.null_m()
    ]
  },
  {
    "text": [
      "What color is the <Z> <C> <M> <S>?",
      "What is the color of the <Z> <C> <M> <S>?",
      "The <Z> <C> <M> <S> has what color?",
      "The <Z> <C> <M> <S> is what color?"
    ],
    "query": frags.match_filter(o) + frags.return_color(o),
    "query2": "MATCH (i)~[:contains]~~<o<S>{<Z><C><M>}> RETURN o.color as color",
    "nodes": [
      nodes.scene,
      nodes.filter_unique(),
      nodes.query_color()
    ],
    "params": params_types.all_props(),
    "constraints": [
      nodes.null_c()
    ]
  },
  {
    "text": [
      "What size is the <Z> <C> <M> <S>?",
      "What is the size of the <Z> <C> <M> <S>?",
      "The <Z> <C> <M> <S> has what size?",
      "The <Z> <C> <M> <S> is what size?",
      "How big is the <Z> <C> <M> <S>?"
    ],
    "query": frags.match_filter(o) + frags.return_size(o),
    "query2": "MATCH (i)~[:contains]~~<o<S>{<Z><C><M>}> RETURN o.size as size",
    "nodes": [
      nodes.scene,
      nodes.filter_unique(),
      nodes.query_size()
    ],
    "params": params_types.all_props(),
    "constraints": [
      nodes.null_z()
    ]
  }
]