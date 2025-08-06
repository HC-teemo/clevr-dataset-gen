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

// local countDual(var1, var2) = _.return([_.count(var1) + '+' + _.count(var2) + ' AS count']);

local countDual(var1, var2) = _.with(['collect( distinct '+ var1 +') + collect(distinct '+var2+') AS all']) + ' unwind all as a ' + _.return(['count( distinct a)']);

local fragement1(filter='') = 
  'MATCH (i)~[:contains]~~<objects%s>'%filter
  + _.with([i,_.coll]) + 
  _.optional + frags.match_one(o) + frags.where_in_obs([o]) + _.with([obs, o]) +
  _.optional + frags.match_one(o2) + frags.where_in_obs([o2]) +
  countDual(o, o2);

[
  {
    "text": [
      "How many things are [either] <Z> <C> <M> <S>s or <Z2> <C2> <M2> <S2>s?",
      "How many objects are [either] <Z> <C> <M> <S>s or <Z2> <C2> <M2> <S2>s?",
      "What number of things are [either] <Z> <C> <M> <S>s or <Z2> <C2> <M2> <S2>s?",
      "What number of objects are [either] <Z> <C> <M> <S>s or <Z2> <C2> <M2> <S2>s?"
    ],
    "query": fragement1(),
    "nodes": [
      nodes.scene,
      nodes.filter('',[0]),
      nodes.scene,
      nodes.filter(2, [2]),
      nodes.union([1,3]),
      nodes.count([4])
    ],
    "params": params_types.all_props() + params_types.all_props(2),
    "constraints": [
      nodes.out_neq([1,3])
    ]
  },
  {
    "text": [
      "How many <Z3> things are [either] <Z> <C> <M> <S>s or <Z2> <C2> <M2> <S2>s?",
      "How many <Z3> objects are [either] <Z> <C> <M> <S>s or <Z2> <C2> <M2> <S2>s?",
      "What number of <Z3> things are [either] <Z> <C> <M> <S>s or <Z2> <C2> <M2> <S2>s?",
      "What number of <Z3> objects are [either] <Z> <C> <M> <S>s or <Z2> <C2> <M2> <S2>s?"
    ],
    "query": fragement1('{<Z3>}'),
    "nodes": [
      nodes.scene,
      nodes.filter('',[0]),
      nodes.scene,
      nodes.filter(2, [2]),
      nodes.union([1,3]),
      nodes.filter_size(3,[4]),
      nodes.count([5])
    ],
    "params": params_types.all_props() + params_types.all_props(2) + [
      {
        "type": "Size",
        "name": "<Z3>"
      }
    ],
    "constraints": [
      nodes.out_neq([1,3]),
      nodes.null_z(),
      nodes.null_z(2)
    ]
  },
  {
    "text": [
      "How many <C3> things are [either] <Z> <C> <M> <S>s or <Z2> <C2> <M2> <S2>s?",
      "How many <C3> objects are [either] <Z> <C> <M> <S>s or <Z2> <C2> <M2> <S2>s?",
      "What number of <C3> things are [either] <Z> <C> <M> <S>s or <Z2> <C2> <M2> <S2>s?",
      "What number of <C3> objects are [either] <Z> <C> <M> <S>s or <Z2> <C2> <M2> <S2>s?"
    ],
    "query": fragement1('{<C3>}'),
    "nodes": [
      nodes.scene,
      nodes.filter('',[0]),
      nodes.scene,
      nodes.filter(2, [2]),
      nodes.union([1,3]),
      nodes.filter_color(3,[4]),
      nodes.count([5])
    ],
    "params": params_types.all_props() + params_types.all_props(2) + [
      {
        "type": "Color",
        "name": "<C3>"
      }
    ],
    "constraints": [
      nodes.out_neq([1,3]),
      nodes.null_c(),
      nodes.null_c(2)
    ]
  },
  {
    "text": [
      "How many things are [either] <Z2> <C2> <M2> <S2>s [that are] <R> the <Z> <C> <M> <S> or <Z4> <C4> <M4> <S4>s [that are] <R2> the <Z3> <C3> <M3> <S3>?",
      "How many objects are [either] <Z2> <C2> <M2> <S2>s [that are] <R> the <Z> <C> <M> <S> or <Z4> <C4> <M4> <S4>s [that are] <R2> the <Z3> <C3> <M3> <S3>?",
      "What number of objects are [either] <Z2> <C2> <M2> <S2>s [that are] <R> the <Z> <C> <M> <S> or <Z4> <C4> <M4> <S4>s [that are] <R2> the <Z3> <C3> <M3> <S3>?",
      "What number of things are [either] <Z2> <C2> <M2> <S2>s [that are] <R> the <Z> <C> <M> <S> or <Z4> <C4> <M4> <S4>s [that are] <R2> the <Z3> <C3> <M3> <S3>?"
    ],
    "query": frags.orooro + frags.where_neq(o2,o4,'') + countDual(o2, o4) ,
    "nodes": [
      nodes.scene,
      nodes.filter_unique(),
      nodes.relate_filter(2,'', [1]),
      nodes.scene,
      nodes.filter_unique(3,[3]),
      nodes.relate_filter(4,'2', [4]),
      nodes.union([2,5]),
      nodes.count([6])
    ],
    "params": params_types.orooro,
    "constraints": []
  },
  {
    "text": [
      "How many <M3> things are [either] <Z> <C> <M> <S>s or <Z2> <C2> <M2> <S2>s?",
      "How many <M3> objects are [either] <Z> <C> <M> <S>s or <Z2> <C2> <M2> <S2>s?",
      "What number of <M3> things are [either] <Z> <C> <M> <S>s or <Z2> <C2> <M2> <S2>s?",
      "What number of <M3> objects are [either] <Z> <C> <M> <S>s or <Z2> <C2> <M2> <S2>s?"
    ],
    "query": fragement1('{<M3>}'),
    "nodes": [
      nodes.scene,
      nodes.filter('',[0]),
      nodes.scene,
      nodes.filter(2, [2]),
      nodes.union([1,3]),
      nodes.filter_material(3,[4]),
      nodes.count([5])
    ],
    "params": params_types.all_props() + params_types.all_props(2) + [
      {
        "type": "Material",
        "name": "<M3>"
      }
    ],
    "constraints": [
      nodes.out_neq([1,3]),
      nodes.null_m(),
      nodes.null_m(2)
    ]
  },
  {
    "text": [
      "How many <S3>s are [either] <Z> <C> <M> <S>s or <Z2> <C2> <M2> <S2>s?",
      "What number of <S3>s are [either] <Z> <C> <M> <S>s or <Z2> <C2> <M2> <S2>s?"
    ],
    "query": 'MATCH (i)~[:contains]~~<objects<S3>>'
      + _.with([i,_.coll]) + 
      _.optional + frags.match_one(o) + frags.where_in_obs([o]) + _.with([obs, o]) +
      _.optional + frags.match_one(o2) + frags.where_in_obs([o2]) +
      countDual(o, o2), // teshu
    "nodes": [
      nodes.scene,
      nodes.scene,
      nodes.filter('',[0]),
      nodes.filter(2, [1]),
      nodes.union([2,3]),
      nodes.filter_shape(3,[4]),
      nodes.count([5])
    ],
    "params": params_types.all_props() + params_types.all_props(2) + [
      {
        "type": "Shape",
        "name": "<S3>"
      }
    ],
    "constraints": [
      nodes.out_neq([2,3]),
      nodes.null_s(),
      nodes.null_s(2)
    ]
  },
  {
    "text": [
      "How many things are [either] <Z2> <C2> <M2> <S2>s [that are] <R> the <Z> <C> <M> <S> or <Z3> <C3> <M3> <S3>s?",
      "How many objects are [either] <Z2> <C2> <M2> <S2>s [that are] <R> the <Z> <C> <M> <S> or <Z3> <C3> <M3> <S3>s?",
      "What number of things are [either] <Z2> <C2> <M2> <S2>s [that are] <R> the <Z> <C> <M> <S> or <Z3> <C3> <M3> <S3>s?",
      "What number of objects are [either] <Z2> <C2> <M2> <S2>s [that are] <R> the <Z> <C> <M> <S> or <Z3> <C3> <M3> <S3>s?"
    ],
    "query": [
      frags.match_all_and, 
      _.optional + frags.match_oro(o, r, o2), frags.where_in_obs([o,o2]), _.with([i, obs, o2]),
      _.optional + frags.match_one(o3), frags.where_in_obs([o3]),
      // frags.where_neq(o3, o2, ''),
      countDual(o2, o3)
    ],
    "nodes": [
      nodes.scene,
      nodes.filter_unique(),
      nodes.relate_filter(2,'', [1]),
      nodes.scene,
      nodes.filter(3, [3]),
      nodes.union([2,4]),
      nodes.count([5])
    ],
    "params": params_types.oroo,
    "constraints": []
  },
  {
    "text": [
      "How many things are [either] <Z> <C> <M> <S>s or <Z3> <C3> <M3> <S3>s [that are] <R> the <Z2> <C2> <M2> <S2>?",
      "How many objects are [either] <Z> <C> <M> <S>s or <Z3> <C3> <M3> <S3>s [that are] <R> the <Z2> <C2> <M2> <S2>?",
      "What number of things are [either] <Z> <C> <M> <S>s or <Z3> <C3> <M3> <S3>s [that are] <R> the <Z2> <C2> <M2> <S2>?",
      "What number of objects are [either] <Z> <C> <M> <S>s or <Z3> <C3> <M3> <S3>s [that are] <R> the <Z2> <C2> <M2> <S2>?"
    ],
    "query": [
      frags.match_all_and, 
      _.optional + frags.match_oro(o2, r, o3), frags.where_in_obs([o2,o3]), _.with([i, obs, o3]),
      _.optional + frags.match_one(o), frags.where_in_obs([o]),
      // frags.where_neq(o3, o, ''),
      countDual(o, o3)
    ],
    "nodes": [
      nodes.scene,
      nodes.filter('',[0]),
      nodes.scene,
      nodes.filter_unique(2, [2]),
      nodes.relate_filter(3,'', [3]),
      nodes.union([1,4]),
      nodes.count([5])
    ],
    "params": params_types.ooro,
    "constraints": []
  }
]