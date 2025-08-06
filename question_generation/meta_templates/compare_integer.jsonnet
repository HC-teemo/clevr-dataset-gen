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


local fragement1(op) = [
  _.optional + frags.match_filter(o),
  // _.with([_.item(i), _.countAs(o)]),
  _.optional + frags.match_filter(o2),
  _.return([_.countD(o) + op + _.countD(o2)])
];

local fragement2(op) = [
  frags.match_all(obs),
  _.with([_.coll]),
  _.optional + frags.match_oro(o, r, o2),
  frags.where_in_obs([o,o2]),
  // _.with([_.countAs(o2), obs]),
  _.optional + frags.match_one(o3),
  frags.where_in_obs([o3]),
  // _.with([_.countAs(o3), _.item('count'+o2)]),
  _.return([_.countD(o2) + op + _.countD(o3)])
];

local fragement3(op) = [
  frags.match_all(obs),
  _.with([_.coll]),
  _.optional + frags.match_oro(o, r, o2),
  frags.where_in_obs([o,o2]),
  // _.with([_.countAs(o2), obs]),
  _.optional + frags.match_oro(o3, r2, o4),
  frags.where_in_obs([o3, o4]),
  // _.with([_.countAs(o4), _.item('count'+o2)]),
  _.return([_.countD(o2) + op + _.countD(o4)])
];

[
  {
    "text": [
      "Are there an equal number of <Z> <C> <M> <S>s and <Z2> <C2> <M2> <S2>s?",
      "Are there the same number of <Z> <C> <M> <S>s and <Z2> <C2> <M2> <S2>s?",
      "Is the number of <Z> <C> <M> <S>s the same as the number of <Z2> <C2> <M2> <S2>s?"
    ],
    "query": fragement1('='),
    "query2": [
      "OPTIONAL MATCH (i)~[:contains]~~<o1<S>{<Z><C><M>}>",
      "WITH i, count(o1) as count1",
      "OPTIONAL MATCH (i)~[:contains]~~<o2<S2>{<Z2><C2><M2>}>",
      "RETURN count1=count(o2) as same"],
    "nodes": [
      nodes.scene,
      nodes.filter_count(),
      nodes.scene,
      nodes.filter_count(2, [2]),
      nodes.equal_integer(inputs = [1,3])
    ],
    "params": params_types.all_props() + params_types.all_props(2),
    "constraints": [
      nodes.out_neq([1,3])
    ]
  },
  {
    "text": [
      "Are there fewer <Z> <C> <M> <S>s than <Z2> <C2> <M2> <S2>s?",
      "Is the number of <Z> <C> <M> <S>s less than the number of <Z2> <C2> <M2> <S2>s?"
    ],
    "query": fragement1('<'),
    "query2": [
      "OPTIONAL MATCH (i)~[:contains]~~<o1<S>{<Z><C><M>}>",
      "WITH i, count(o1) as count1",
      "OPTIONAL MATCH (i)~[:contains]~~<o2<S2>{<Z2><C2><M2>}>",
      "RETURN count1<count(o2) as same"],
    "nodes": [
      nodes.scene,
      nodes.filter_count(),
      nodes.scene,
      nodes.filter_count(2, [2]),
      nodes.less_than(inputs = [1,3])
    ],
    "params": params_types.all_props() + params_types.all_props(2),
    "constraints": [
      nodes.out_neq([1,3])
    ]
  },
  {
    "text": [
      "Are there more <Z> <C> <M> <S>s than <Z2> <C2> <M2> <S2>s?",
      "Is the number of <Z> <C> <M> <S>s greater than the number of <Z2> <C2> <M2> <S2>s?"
    ],
    "query": fragement1('>'),
    "query2": [
      "OPTIONAL MATCH (i)~[:contains]~~<o1<S>{<Z><C><M>}>",
      "WITH i, count(o1) as count1",
      "OPTIONAL MATCH (i)~[:contains]~~<o2<S2>{<Z2><C2><M2>}>",
      "RETURN count1>count(o2) as same"],
    "nodes": [
      nodes.scene,
      nodes.filter_count(),
      nodes.scene,
      nodes.filter_count(2, [2]),
      nodes.greater_than(inputs=[1,3])
    ],
    "params": params_types.all_props() + params_types.all_props(2),
    "constraints": [
      nodes.out_neq([1,3])
    ]
  },
  {
    "text": [
      "Are there the same number of <Z2> <C2> <M2> <S2>s [that are] <R> the <Z> <C> <M> <S> and <Z3> <C3> <M3> <S3>s?",
      "Are there an equal number of <Z2> <C2> <M2> <S2>s [that are] <R> the <Z> <C> <M> <S> and <Z3> <C3> <M3> <S3>s?",
      "Is the number of <Z2> <C2> <M2> <S2>s [that are] <R> the <Z> <C> <M> <S> the same as the number of <Z3> <C3> <M3> <S3>s?"
    ],
    "query": fragement2('='),
    "query2": [
      "OPTIONAL MATCH (i)~[:contains]~~<o<S>{<Z><C><M>}>,",
      "(i)~[:contains]~~<o2<S2>{<Z2><C2><M2>}>~~[<R>]~<o>",
      "WITH count(o2) as count2, i",
      "OPTIONAL MATCH (i)~[:contains]~~<o3<S3>{<Z3><C3><M3>}>",
      "WITH count(o3) as count3, count2",
      "RETURN count2 = count3 as same"],
    "nodes": [
      nodes.scene,
      nodes.filter_unique(),
      nodes.relate_filter_count(2,'',[1]),
      nodes.scene, 
      nodes.filter_count(3,[3]),
      nodes.equal_integer([2,4])
    ],
    "params": params_types.oroo,
    "constraints": []
  },
  {
    "text": [
      "Are there fewer <Z2> <C2> <M2> <S2>s [that are] <R> the <Z> <C> <M> <S> than <Z3> <C3> <M3> <S3>s?",
      "Is the number of <Z2> <C2> <M2> <S2>s [that are] <R> the <Z> <C> <M> <S> less than the number of <Z3> <C3> <M3> <S3>s?"
    ],
    "query": fragement2('<'),
    "query2": [
      "OPTIONAL MATCH (i)~[:contains]~~<o<S>{<Z><C><M>}>,",
      "(i)~[:contains]~~<o2<S2>{<Z2><C2><M2>}>~~[<R>]~<o>",
      "WITH count(o2) as count2, i",
      "OPTIONAL MATCH (i)~[:contains]~~<o3<S3>{<Z3><C3><M3>}>",
      "WITH count(o3) as count3, count2",
      "RETURN count2 < count3 as same"],
    "nodes": [
      nodes.scene,
      nodes.filter_unique(),
      nodes.relate_filter_count(2,'',[1]),
      nodes.scene,
      nodes.filter_count(3,[3]),
      nodes.less_than([2,4])
    ],
    "params": params_types.oroo,
    "constraints": []
  },
  {
    "text": [
      "Are there more <Z2> <C2> <M2> <S2>s [that are] <R> the <Z> <C> <M> <S> than <Z3> <C3> <M3> <S3>s?",
      "Is the number of <Z2> <C2> <M2> <S2>s [that are] <R> the <Z> <C> <M> <S> greater than the number of <Z3> <C3> <M3> <S3>s?"
    ],
    "query": fragement2('>'),
    "query2": [
      "OPTIONAL MATCH (i)~[:contains]~~<o<S>{<Z><C><M>}>,",
      "(i)~[:contains]~~<o2<S2>{<Z2><C2><M2>}>~~[<R>]~<o>",
      "WITH count(o2) as count2, i",
      "OPTIONAL MATCH (i)~[:contains]~~<o3<S3>{<Z3><C3><M3>}>",
      "WITH count(o3) as count3, count2",
      "RETURN count2 > count3 as same"],
    "nodes": [
      nodes.scene,
      nodes.filter_unique(),
      nodes.relate_filter_count(2,'',[1]),
      nodes.scene,
      nodes.filter_count(3,[3]),
      nodes.greater_than([2,4])
    ],
    "params": params_types.oroo,
    "constraints": []
  },
  {
    "text": [
      "Is the number of <Z2> <C2> <M2> <S2>s [that are] <R> the <Z> <C> <M> <S> the same as the number of <Z4> <C4> <M4> <S4>s [that are] <R2> the <Z3> <C3> <M3> <S3>?",
      "Are there an equal number of <Z2> <C2> <M2> <S2>s [that are] <R> the <Z> <C> <M> <S> and <Z4> <C4> <M4> <S4>s [that are] <R2> the <Z3> <C3> <M3> <S3>?",
      "Are there the same number of <Z2> <C2> <M2> <S2>s [that are] <R> the <Z> <C> <M> <S> and <Z4> <C4> <M4> <S4>s [that are] <R2> the <Z3> <C3> <M3> <S3>?"
    ],
    query: fragement3('='),
    "query2": [
      "OPTIONAL MATCH (i)~[:contains]~~<o<S>{<Z><C><M>}>,",
      "(i)~[:contains]~~<o2<S2>{<Z2><C2><M2>}>~~[<R>]~<o>",
      "WITH count(o2) as count2, i",
      "OPTIONAL MATCH (i)~[:contains]~~<o3<S3>{<Z3><C3><M3>}>,",
      "(i)~[:contains]~~<o4<S4>{<Z4><C4><M4>}>~~[<R2>]~<o3>",
      "WITH count(o4) as count4, count2",
      "RETURN count2 = count4 as same"],
    "nodes": [
      nodes.scene,
      nodes.filter_unique(),
      nodes.relate_filter_count(2,'',[1]),
      nodes.scene,
      nodes.filter_unique(3,[3]),
      nodes.relate_filter_count(4,2,[4]),
      nodes.equal_integer([2,5])
    ],
    "params": params_types.orooro,
    "constraints": [
      nodes.out_neq([1,4])
    ]
  },
  {
    "text": [
      "Is the number of <Z2> <C2> <M2> <S2>s [that are] <R> the <Z> <C> <M> <S> less than the number of <Z4> <C4> <M4> <S4>s [that are] <R2> the <Z3> <C3> <M3> <S3>?",
      "Are there fewer <Z2> <C2> <M2> <S2>s [that are] <R> the <Z> <C> <M> <S> than <Z4> <C4> <M4> <S4>s [that are] <R2> the <Z3> <C3> <M3> <S3>?"
    ],
    query: fragement3('<'),
    "query2": [
      "OPTIONAL MATCH (i)~[:contains]~~<o<S>{<Z><C><M>}>,",
      "(i)~[:contains]~~<o2<S2>{<Z2><C2><M2>}>~~[<R>]~<o>",
      "WITH count(o2) as count2, i",
      "OPTIONAL MATCH (i)~[:contains]~~<o3<S3>{<Z3><C3><M3>}>,",
      "(i)~[:contains]~~<o4<S4>{<Z4><C4><M4>}>~~[<R2>]~<o3>",
      "WITH count(o4) as count4, count2",
      "RETURN count2 < count4 as same"],
    "nodes": [
      nodes.scene,
      nodes.filter_unique(),
      nodes.relate_filter_count(2,'',[1]),
      nodes.scene,
      nodes.filter_unique(3,[3]),
      nodes.relate_filter_count(4,2,[4]),
      nodes.less_than([2,5])
    ],
    "params": params_types.orooro,
    "constraints": [
      nodes.out_neq([1,4])
    ]
  },
  {
    "text": [
      "Are there more <Z2> <C2> <M2> <S2>s [that are] <R> the <Z> <C> <M> <S> than <Z4> <C4> <M4> <S4>s [that are] <R2> the <Z3> <C3> <M3> <S3>?",
      "Is the number of <Z2> <C2> <M2> <S2>s [that are] <R> the <Z> <C> <M> <S> greater than the number of <Z4> <C4> <M4> <S4>s [that are] <R2> the <Z3> <C3> <M3> <S3>?"
    ],
    query: fragement3('>'),
    "query2": [
      "OPTIONAL MATCH (i)~[:contains]~~<o<S>{<Z><C><M>}>,",
      "(i)~[:contains]~~<o2<S2>{<Z2><C2><M2>}>~~[<R>]~<o>",
      "WITH count(o2) as count2, i",
      "OPTIONAL MATCH (i)~[:contains]~~<o3<S3>{<Z3><C3><M3>}>,",
      "(i)~[:contains]~~<o4<S4>{<Z4><C4><M4>}>~~[<R2>]~<o3>",
      "WITH count(o4) as count4, count2",
      "RETURN count2 > count4 as same"],
    "nodes": [
      nodes.scene,
      nodes.filter_unique(),
      nodes.relate_filter_count(2,'',[1]),
      nodes.scene,
      nodes.filter_unique(3,[3]),
      nodes.relate_filter_count(4,2,[4]),
      nodes.greater_than([2,5])
    ],
    "params": params_types.orooro,
    "constraints": [
      nodes.out_neq([1,4])
    ]
  }
]