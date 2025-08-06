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

local fragement1(prop) = frags.match_filter(o) + ", " + frags.tripet_filter(o2) + frags.same(o, o2, prop);

local fragement2(o, o2, o3, prop) = [
  frags.match_all_and, 
  frags.match_oro(o, r, o2), frags.where_in_obs([o,o2]), 
  // _.with([i, obs, o2]),
  frags.match_one(o3), frags.where_in_obs([o3]),
  //  _.with([o2, o3]),
  frags.same(o2, o3, prop)
];

local fragement3(prop) = frags.orooro + frags.same(o2, o4, prop);

[
  {
    "text": [
      "Do the <Z> <C> <M> <S> and the <Z2> <C2> <M2> <S2> have the same size?",
      "Is the size of the <Z> <C> <M> <S> the same as the <Z2> <C2> <M2> <S2>?",
      "Do the <Z> <C> <M> <S> and the <Z2> <C2> <M2> <S2> have the same size?",
      "Is the <Z> <C> <M> <S> the same size as the <Z2> <C2> <M2> <S2>?",
      "Does the <Z> <C> <M> <S> have the same size as the <Z2> <C2> <M2> <S2>?"
    ],
    "query": fragement1('size'),
    "query2": "MATCH (i)~[:contains]~~<o1<S>{<Z><C><M>}>, (i)~[:contains]~~<o2<S2>{<Z2><C2><M2>}> RETURN o1.size=o2.size as same",
    "nodes": [
      nodes.scene,
      nodes.filter_unique(),
      nodes.scene, 
      nodes.filter_unique(2, [2]),
      nodes.query_size([1]),
      nodes.query_size([3]),
      nodes.equal_size([4,5])
    ],
    "params": params_types.oo,
    "constraints": [
      nodes.null_z(), 
      nodes.null_z(2),
      nodes.out_neq([1,3])
    ]
  },
  {
    "text": [
      "Do the <Z> <C> <M> <S> and the <Z2> <C2> <M2> <S2> have the same color?",
      "Is the color of the <Z> <C> <M> <S> the same as the <Z2> <C2> <M2> <S2>?",
      "Does the <Z> <C> <M> <S> have the same color as the <Z2> <C2> <M2> <S2>?",
      "Is the <Z> <C> <M> <S> the same color as the <Z2> <C2> <M2> <S2>?"
    ],
    "query": fragement1('color'),
    "query2": "MATCH (i)~[:contains]~~<o1<S>{<Z><C><M>}>, (i)~[:contains]~~<o2<S2>{<Z2><C2><M2>}> RETURN o1.color=o2.color as same",
    "nodes": [
      nodes.scene,
      nodes.filter_unique(),
      nodes.scene,
      nodes.filter_unique(2, [2]),
      nodes.query_color([1]),
      nodes.query_color([3]),
      nodes.equal_color([4,5])
    ],
    "params": params_types.oo,
    "constraints": [
      nodes.null_c(),
      nodes.null_c(2),
      nodes.out_neq([1,3])
    ]
  },
  {
    "text": [
      "Do the <Z> <C> <M> <S> and the <Z2> <C2> <M2> <S2> have the same material?",
      "Are the <Z> <C> <M> <S> and the <Z2> <C2> <M2> <S2> made of the same material?",
      "Is the material of the <Z> <C> <M> <S> the same as the <Z2> <C2> <M2> <S2>?",
      "Does the <Z> <C> <M> <S> have the same material as the <Z2> <C2> <M2> <S2>?",
      "Is the <Z> <C> <M> <S> made of the same material as the <Z2> <C2> <M2> <S2>?"
    ],
    "query": fragement1('material'),
    "query2": "MATCH (i)~[:contains]~~<o1<S>{<Z><C><M>}>, (i)~[:contains]~~<o2<S2>{<Z2><C2><M2>}> RETURN o1.material=o2.material as same",
    "nodes": [
      nodes.scene,
      nodes.filter_unique(),
      nodes.query_material([1]),
      nodes.scene,
      nodes.filter_unique(2, [3]),
      nodes.query_material([4]),
      nodes.equal_material([2,5])
    ],
    "params": params_types.oo,
    "constraints": [
      nodes.out_neq([1,4]),
      nodes.null_m(),
      nodes.null_m(2)
    ]
  },
  {
    "text": [
      "Do the <Z> <C> <M> <S> and the <Z2> <C2> <M2> <S2> have the same shape?",
      " Does the <Z> <C> <M> <S> have the same shape as the <Z2> <C2> <M2> <S2>?",
      "Is the shape of the <Z> <C> <M> <S> the same as the <Z2> <C2> <M2> <S2>?",
      "Is the <Z> <C> <M> <S> the same shape as the <Z2> <C2> <M2> <S2>?"
    ],
    "query": fragement1('shape'),
    "query2": "MATCH (i)~[:contains]~~<o1<S>{<Z><C><M>}>, (i)~[:contains]~~<o2<S2>{<Z2><C2><M2>}> RETURN labels(o1)=labels(o2) as same",
    "nodes": [
      nodes.scene,
      nodes.filter_unique(),
      nodes.query_shape([1]),
      nodes.scene,
      nodes.filter_unique(2, [3]),
      nodes.query_shape([4]),
      nodes.equal_shape([2,5])
    ],
    "params": params_types.oo,
    "constraints": [
      nodes.null_s(),
      nodes.null_s(2),
      nodes.out_neq([1,4])
    ]
  },
  {
    "text": [
      "Is the size of the <Z2> <C2> <M2> <S2> [that is] <R> the <Z> <C> <M> <S> the same as the <Z3> <C3> <M3> <S3>?",
      "Does the <Z2> <C2> <M2> <S2> [that is] <R> the <Z> <C> <M> <S> have the same size as the <Z3> <C3> <M3> <S3>?",
      "Do the <Z2> <C2> <M2> <S2> [that is] <R> the <Z> <C> <M> <S> and the <Z3> <C3> <M3> <S3> have the same size?",
      "There is a <Z2> <C2> <M2> <S2> [that is] <R> the <Z> <C> <M> <S>; does it have the same size as the <Z3> <C3> <M3> <S3>?",
      "There is a <Z2> <C2> <M2> <S2> [that is] <R> the <Z> <C> <M> <S>; is it the same size as the <Z3> <C3> <M3> <S3>?",
      "There is a <Z2> <C2> <M2> <S2> [that is] <R> the <Z> <C> <M> <S>; is its size the same as the <Z3> <C3> <M3> <S3>?"
    ],
    "query": fragement2(o, o2, o3, 'size'),
    "query2": [
      "MATCH (i)~[:contains]~~<o<S>{<Z><C><M>}>",
      "WITH i,o",
      "MATCH (i)~[:contains]~~<o2<S2>{<Z2><C2><M2>}>~~[<R>]~<o>, (i)~[:contains]~~<o3<S3>{<Z3><C3><M3>}>",
      "RETURN o2.size = o3.size as same"],
    "nodes": [
      nodes.scene,
      nodes.filter_unique(),
      nodes.relate_filter_unique(2,'',[1]),
      nodes.query_size([2]),
      nodes.scene,
      nodes.filter_unique(3,[4]),
      nodes.query_size([5]),
      nodes.equal_size([3,6])
    ],
    "params": params_types.oroo,
    "constraints": [
      nodes.out_neq([2,5]),
      nodes.null_z(2),
      nodes.null_z()
    ]
  },
  {
    "text": [
      "Is the size of the <Z> <C> <M> <S> the same as the <Z3> <C3> <M3> <S3> [that is] <R> the <Z2> <C2> <M2> <S2>?",
      "Does the <Z> <C> <M> <S> have the same size as the <Z3> <C3> <M3> <S3> [that is] <R> the <Z2> <C2> <M2> <S2>?",
      "Do the <Z> <C> <M> <S> and the <Z3> <C3> <M3> <S3> [that is] <R> the <Z2> <C2> <M2> <S2> have the same size?",
      "There is a <Z> <C> <M> <S>; does it have the same size as the <Z3> <C3> <M3> <S3> [that is] <R> the <Z2> <C2> <M2> <S2>?",
      "There is a <Z> <C> <M> <S>; is its size the same as the <Z3> <C3> <M3> <S3> [that is] <R> the <Z2> <C2> <M2> <S2>?",
      "There is a <Z> <C> <M> <S>; is it the same size as the <Z3> <C3> <M3> <S3> [that is] <R> the <Z2> <C2> <M2> <S2>?"
    ],
    "query": fragement2(o2, o3, o, 'size'),
    "query2": [
      "MATCH (i)~[:contains]~~<o<S>{<Z><C><M>}>",
      "WITH i,o",
      "MATCH (i)~[:contains]~~<o2<S2>{<Z2><C2><M2>}>, (i)~[:contains]~~<o3<S3>{<Z3><C3><M3>}>~~[<R>]~<o2>",
      "RETURN o.size = o3.size as same"],
    "nodes": [
      nodes.scene,
      nodes.filter_unique(),
      nodes.query_size([1]),
      nodes.scene,
      nodes.filter_unique(2, [3]),
      nodes.relate_filter_unique(3,'',[4]),
      nodes.query_size([5]),
      nodes.equal_size([2,6])
    ],
    "params": params_types.ooro,
    "constraints": [
      nodes.out_neq([1,5]),
      nodes.null_z(),
      nodes.null_z(3)
    ]
  },
  {
    "text": [
      "Is the size of the <Z2> <C2> <M2> <S2> [that is] <R> the <Z> <C> <M> <S> the same as the <Z4> <C4> <M4> <S4> [that is] <R2> the <Z3> <C3> <M3> <S3>?",
      "Does the <Z2> <C2> <M2> <S2> [that is] <R> the <Z> <C> <M> <S> have the same size as the <Z4> <C4> <M4> <S4> [that is] <R2> the <Z3> <C3> <M3> <S3>?",
      "Do the <Z2> <C2> <M2> <S2> [that is] <R> the <Z> <C> <M> <S> and the <Z4> <C4> <M4> <S4> [that is] <R2> the <Z3> <C3> <M3> <S3> have the same size?",
      "There is a <Z2> <C2> <M2> <S2> [that is] <R> the <Z> <C> <M> <S>; does it have the same size as the <Z4> <C4> <M4> <S4> [that is] <R2> the <Z3> <C3> <M3> <S3>?",
      "There is a <Z2> <C2> <M2> <S2> [that is] <R> the <Z> <C> <M> <S>; is its size the same as the <Z4> <C4> <M4> <S4> [that is] <R2> the <Z3> <C3> <M3> <S3>?",
      "There is a <Z2> <C2> <M2> <S2> [that is] <R> the <Z> <C> <M> <S>; is it the same size as the <Z4> <C4> <M4> <S4> [that is] <R2> the <Z3> <C3> <M3> <S3>?"
    ],
    "query": fragement3('size'),
    "query2": [
      "MATCH (i)~[:contains]~~<o<S>{<Z><C><M>}>, (i)~[:contains]~~<o2<S2>{<Z2><C2><M2>}>~~[<R>]~<o>",
      "WITH i, o2",
      "MATCH (i)~[:contains]~~<o3<S3>{<Z3><C3><M3>}>, (i)~[:contains]~~<o4<S4>{<Z4><C4><M4>}>~~[<R2>]~<o3>",
      "RETURN o2.size = o4.size as same"],
    "nodes": [
      nodes.scene,
      nodes.filter_unique(),
      nodes.relate_filter_unique(2,'',[1]),
      nodes.query_size([2]),
      nodes.scene,
      nodes.filter_unique(3,[4]),
      nodes.relate_filter_unique(4,2,[5]),
      nodes.query_size([6]),
      nodes.equal_size([3,7])
    ],
    "params": params_types.orooro,
    "constraints": [
      nodes.out_neq([2,6]),
      nodes.null_z(2),
      nodes.null_z(4)
    ]
  },
  {
    "text": [
      "Is the color of the <Z2> <C2> <M2> <S2> [that is] <R> the <Z> <C> <M> <S> the same as the <Z3> <C3> <M3> <S3>?",
      "Does the <Z2> <C2> <M2> <S2> [that is] <R> the <Z> <C> <M> <S> have the same color as the <Z3> <C3> <M3> <S3>?",
      "Do the <Z2> <C2> <M2> <S2> [that is] <R> the <Z> <C> <M> <S> and the <Z3> <C3> <M3> <S3> have the same color?",
      "There is a <Z2> <C2> <M2> <S2> [that is] <R> the <Z> <C> <M> <S>; does it have the same color as the <Z3> <C3> <M3> <S3>?",
      "There is a <Z2> <C2> <M2> <S2> [that is] <R> the <Z> <C> <M> <S>; is it the same color as the <Z3> <C3> <M3> <S3>?",
      "There is a <Z2> <C2> <M2> <S2> [that is] <R> the <Z> <C> <M> <S>; is its color the same as the <Z3> <C3> <M3> <S3>?"
    ],
    "query": fragement2(o, o2, o3, 'color'),
    "query2": [
      "MATCH (i)~[:contains]~~<o<S>{<Z><C><M>}>, (i)~[:contains]~~<o2<S2>{<Z2><C2><M2>}>~~[<R>]~<o>",
      "WITH i, o2",
      "MATCH (i)~[:contains]~~<o3<S3>{<Z3><C3><M3>}>",
      "RETURN o2.color = o3.color as same"],
    "nodes": [
      nodes.scene,
      nodes.filter_unique(),
      nodes.relate_filter_unique(2,'',[1]),
      nodes.query_color([2]),
      nodes.scene,
      nodes.filter_unique(3,[4]),
      nodes.query_color([5]),
      nodes.equal_color([3,6])
    ],
    "params": params_types.oroo,
    "constraints": [
      nodes.out_neq([2,5]),
      nodes.null_c(2),
      nodes.null_c(3)
    ]
  },
  {
    "text": [
      "Is the color of the <Z> <C> <M> <S> the same as the <Z3> <C3> <M3> <S3> [that is] <R> the <Z2> <C2> <M2> <S2>?",
      "Does the <Z> <C> <M> <S> have the same color as the <Z3> <C3> <M3> <S3> [that is] <R> the <Z2> <C2> <M2> <S2>?",
      "Do the <Z> <C> <M> <S> and the <Z3> <C3> <M3> <S3> [that is] <R> the <Z2> <C2> <M2> <S2> have the same color?",
      "There is a <Z> <C> <M> <S>; does it have the same color as the <Z3> <C3> <M3> <S3> [that is] <R> the <Z2> <C2> <M2> <S2>?",
      "There is a <Z> <C> <M> <S>; is its color the same as the <Z3> <C3> <M3> <S3> [that is] <R> the <Z2> <C2> <M2> <S2>?",
      "There is a <Z> <C> <M> <S>; is it the same color as the <Z3> <C3> <M3> <S3> [that is] <R> the <Z2> <C2> <M2> <S2>?"
    ],
    "query": fragement2(o2, o3, o, 'color'),
    "query2": [
      "MATCH (i)~[:contains]~~<o2<S2>{<Z2><C2><M2>}>, (i)~[:contains]~~<o3<S3>{<Z3><C3><M3>}>~~[<R>]~<o2>",
      "WITH i, o3",
      "MATCH (i)~[:contains]~~<o<S>{<Z><C><M>}>",
      "RETURN o.color = o3.color as same"],
    "nodes": [
      nodes.scene,
      nodes.filter_unique(),
      nodes.query_color([1]),
      nodes.scene,
      nodes.filter_unique(2, [3]),
      nodes.relate_filter_unique(3,'',[4]),
      nodes.query_color([5]),
      nodes.equal_color([2,6])
    ],
    "params": params_types.ooro,
    "constraints": [
      nodes.out_neq([5,1]),
      nodes.null_c(),
      nodes.null_c(3)
    ]
  },
  {
    "text": [
      "Is the color of the <Z2> <C2> <M2> <S2> [that is] <R> the <Z> <C> <M> <S> the same as the <Z4> <C4> <M4> <S4> [that is] <R2> the <Z3> <C3> <M3> <S3>?",
      "Does the <Z2> <C2> <M2> <S2> [that is] <R> the <Z> <C> <M> <S> have the same color as the <Z4> <C4> <M4> <S4> [that is] <R2> the <Z3> <C3> <M3> <S3>?",
      "Do the <Z2> <C2> <M2> <S2> [that is] <R> the <Z> <C> <M> <S> and the <Z4> <C4> <M4> <S4> [that is] <R2> the <Z3> <C3> <M3> <S3> have the same color?",
      "There is a <Z2> <C2> <M2> <S2> [that is] <R> the <Z> <C> <M> <S>; does it have the same color as the <Z4> <C4> <M4> <S4> [that is] <R2> the <Z3> <C3> <M3> <S3>?",
      "There is a <Z2> <C2> <M2> <S2> [that is] <R> the <Z> <C> <M> <S>; is its color the same as the <Z4> <C4> <M4> <S4> [that is] <R2> the <Z3> <C3> <M3> <S3>?",
      "There is a <Z2> <C2> <M2> <S2> [that is] <R> the <Z> <C> <M> <S>; is it the same color as the <Z4> <C4> <M4> <S4> [that is] <R2> the <Z3> <C3> <M3> <S3>?"
    ],
    "query": fragement3('color'),
    "query2": [
      "MATCH (i)~[:contains]~~<o<S>{<Z><C><M>}>, (i)~[:contains]~~<o2<S2>{<Z2><C2><M2>}>~~[<R>]~<o>",
      "WITH i, o2",
      "MATCH (i)~[:contains]~~<o3<S3>{<Z3><C3><M3>}>, (i)~[:contains]~~<o4<S4>{<Z4><C4><M4>}>~~[<R2>]~<o3>",
      "RETURN o2.color = o4.color as same"],
    "nodes": [
      nodes.scene,
      nodes.filter_unique(),
      nodes.relate_filter_unique(2,'',[1]),
      nodes.query_color([2]),
      nodes.scene,
      nodes.filter_unique(3,[4]),
      nodes.relate_filter_unique(4,2,[5]),
      nodes.query_color([6]),
      nodes.equal_color([3,7])
    ],
    "params": params_types.orooro,
    "constraints": [
      nodes.out_neq([2,6]),
      nodes.null_c(2),
      nodes.null_c(4)
    ]
  },
  {
    "text": [
      "Is the material of the <Z2> <C2> <M2> <S2> [that is] <R> the <Z> <C> <M> <S> the same as the <Z3> <C3> <M3> <S3>?",
      "Does the <Z2> <C2> <M2> <S2> [that is] <R> the <Z> <C> <M> <S> have the same material as the <Z3> <C3> <M3> <S3>?",
      "Do the <Z2> <C2> <M2> <S2> [that is] <R> the <Z> <C> <M> <S> and the <Z3> <C3> <M3> <S3> have the same material?",
      "Are the <Z2> <C2> <M2> <S2> [that is] <R> the <Z> <C> <M> <S> and the <Z3> <C3> <M3> <S3> made of the same material?",
      "Is the <Z2> <C2> <M2> <S2> [that is] <R> the <Z> <C> <M> <S> made of the same material as the <Z3> <C3> <M3> <S3>?"
    ],
    "query": fragement2(o, o2, o3, 'material'),
    "query2": [
      "MATCH (i)~[:contains]~~<o<S>{<Z><C><M>}>, (i)~[:contains]~~<o2<S2>{<Z2><C2><M2>}>~~[<R>]~<o>",
      "WITH i, o2",
      "MATCH (i)~[:contains]~~<o3<S3>{<Z3><C3><M3>}>",
      "RETURN o2.material = o3.material as same"],
    "nodes": [
      nodes.scene,
      nodes.filter_unique(),
      nodes.relate_filter_unique(2,'',[1]),
      nodes.query_material([2]),
      nodes.scene,
      nodes.filter_unique(3,[4]),
      nodes.query_material([5]),
      nodes.equal_material([3,6])
    ],
    "params": params_types.oroo,
    "constraints": [
      nodes.out_neq([2,5]),
      nodes.null_m(2),
      nodes.null_m(3)
    ]
  },
  {
    "text": [
      "Is the material of the <Z> <C> <M> <S> the same as the <Z3> <C3> <M3> <S3> [that is] <R> the <Z2> <C2> <M2> <S2>?",
      "Does the <Z> <C> <M> <S> have the same material as the <Z3> <C3> <M3> <S3> [that is] <R> the <Z2> <C2> <M2> <S2>?",
      "Do the <Z> <C> <M> <S> and the <Z3> <C3> <M3> <S3> [that is] <R> the <Z2> <C2> <M2> <S2> have the same material?",
      "Is the <Z> <C> <M> <S> made of the same material as the <Z3> <C3> <M3> <S3> [that is] <R> the <Z2> <C2> <M2> <S2>?",
      "Are the <Z> <C> <M> <S> and the <Z3> <C3> <M3> <S3> [that is] <R> the <Z2> <C2> <M2> <S2> made of the same material?"
    ],
    "query": fragement2(o2, o3, o, 'material'),
    "query2": [
      "MATCH (i)~[:contains]~~<o2<S2>{<Z2><C2><M2>}>, (i)~[:contains]~~<o3<S3>{<Z3><C3><M3>}>~~[<R>]~<o2>",
      "WITH i, o3",
      "MATCH (i)~[:contains]~~<o<S>{<Z><C><M>}>",
      "RETURN o.material = o3.material as same"],
    "nodes": [
      nodes.scene,
      nodes.filter_unique(),
      nodes.query_material([1]),
      nodes.scene,
      nodes.filter_unique(2, [3]),
      nodes.relate_filter_unique(3,'',[4]),
      nodes.query_material([5]),
      nodes.equal_material([2,6])
    ],
    "params": params_types.ooro,
    "constraints": [
      nodes.out_neq([1,5]),
      nodes.null_m(),
      nodes.null_m(3)
    ]
  },
  {
    "text": [
      "Is the material of the <Z2> <C2> <M2> <S2> [that is] <R> the <Z> <C> <M> <S> the same as the <Z4> <C4> <M4> <S4> [that is] <R2> the <Z3> <C3> <M3> <S3>?",
      "Does the <Z2> <C2> <M2> <S2> [that is] <R> the <Z> <C> <M> <S> have the same material as the <Z4> <C4> <M4> <S4> [that is] <R2> the <Z3> <C3> <M3> <S3>?",
      "Do the <Z2> <C2> <M2> <S2> [that is] <R> the <Z> <C> <M> <S> and the <Z4> <C4> <M4> <S4> [that is] <R2> the <Z3> <C3> <M3> <S3> have the same material?",
      "Is the <Z2> <C2> <M2> <S2> [that is] <R> the <Z> <C> <M> <S> made of the same material as the <Z4> <C4> <M4> <S4> [that is] <R2> the <Z3> <C3> <M3> <S3>?",
      "Are the <Z2> <C2> <M2> <S2> [that is] <R> the <Z> <C> <M> <S> and the <Z4> <C4> <M4> <S4> [that is] <R2> the <Z3> <C3> <M3> <S3> made of the same material?"
    ],
    "query": fragement3('material'),
    "query2": [
      "MATCH (i)~[:contains]~~<o<S>{<Z><C><M>}>, (i)~[:contains]~~<o2<S2>{<Z2><C2><M2>}>~~[<R>]~<o>",
      "WITH i, o2",
      "MATCH (i)~[:contains]~~<o3<S3>{<Z3><C3><M3>}>, (i)~[:contains]~~<o4<S4>{<Z4><C4><M4>}>~~[<R2>]~<o3>",
      "RETURN o2.material = o4.material as same"],
    "nodes": [
      nodes.scene,
      nodes.filter_unique(),
      nodes.relate_filter_unique(2,'',[1]),
      nodes.query_material([2]),
      nodes.scene,
      nodes.filter_unique(3,[4]),
      nodes.relate_filter_unique(4,2,[5]),
      nodes.query_material([6]),
      nodes.equal_material([3,7])
    ],
    "params": params_types.orooro,
    "constraints": [
      nodes.out_neq([2,6]),
      nodes.null_m(2),
      nodes.null_m(4)
    ]
  },
  {
    "text": [
      "Is the shape of the <Z2> <C2> <M2> <S2> [that is] <R> the <Z> <C> <M> <S> the same as the <Z3> <C3> <M3> <S3>?",
      "Does the <Z2> <C2> <M2> <S2> [that is] <R> the <Z> <C> <M> <S> have the same shape as the <Z3> <C3> <M3> <S3>?",
      "Do the <Z2> <C2> <M2> <S2> [that is] <R> the <Z> <C> <M> <S> and the <Z3> <C3> <M3> <S3> have the same shape?",
      "There is a <Z2> <C2> <M2> <S2> [that is] <R> the <Z> <C> <M> <S>; does it have the same shape as the <Z3> <C3> <M3> <S3>?",
      "There is a <Z2> <C2> <M2> <S2> [that is] <R> the <Z> <C> <M> <S>; is it the same shape as the <Z3> <C3> <M3> <S3>?",
      "There is a <Z2> <C2> <M2> <S2> [that is] <R> the <Z> <C> <M> <S>; is its shape the same as the <Z3> <C3> <M3> <S3>?"
    ],
    "query": fragement2(o, o2, o3, 'shape'),
    "query2": [
      "MATCH (i)~[:contains]~~<o<S>{<Z><C><M>}>, (i)~[:contains]~~<o2<S2>{<Z2><C2><M2>}>~~[<R>]~<o>",
      "WITH i, o2",
      "MATCH (i)~[:contains]~~<o3<S3>{<Z3><C3><M3>}>",
      "RETURN labels(o2) = labels(o3) as same"],
    "nodes": [
      nodes.scene,
      nodes.filter_unique(),
      nodes.relate_filter_unique(2,'',[1]),
      nodes.query_shape([2]),
      nodes.scene,
      nodes.filter_unique(3,[4]),
      nodes.query_shape([5]),
      nodes.equal_shape([3,6])
    ],
    "params": params_types.oroo,
    "constraints": [
      nodes.out_neq([2,5]),
      nodes.null_s(2),
      nodes.null_s(3)
    ]
  },
  {
    "text": [
      "Is the shape of the <Z> <C> <M> <S> the same as the <Z3> <C3> <M3> <S3> [that is] <R> the <Z2> <C2> <M2> <S2>?",
      "Does the <Z> <C> <M> <S> have the same shape as the <Z3> <C3> <M3> <S3> [that is] <R> the <Z2> <C2> <M2> <S2>?",
      "Do the <Z> <C> <M> <S> and the <Z3> <C3> <M3> <S3> [that is] <R> the <Z2> <C2> <M2> <S2> have the same shape?",
      "There is a <Z> <C> <M> <S>; does it have the same shape as the <Z3> <C3> <M3> <S3> [that is] <R> the <Z2> <C2> <M2> <S2>?",
      "There is a <Z> <C> <M> <S>; is its shape the same as the <Z3> <C3> <M3> <S3> [that is] <R> the <Z2> <C2> <M2> <S2>?",
      "There is a <Z> <C> <M> <S>; is it the same shape as the <Z3> <C3> <M3> <S3> [that is] <R> the <Z2> <C2> <M2> <S2>?"
    ],
    "query": fragement2(o2, o3, o, 'shape'),
    "query2": [
      "MATCH (i)~[:contains]~~<o2<S2>{<Z2><C2><M2>}>, (i)~[:contains]~~<o3<S3>{<Z3><C3><M3>}>~~[<R>]~<o2>",
      "WITH i, o3",
      "MATCH (i)~[:contains]~~<o<S>{<Z><C><M>}>",
      "RETURN labels(o) = labels(o3) as same"],
    "nodes": [
      nodes.scene,
      nodes.filter_unique(),
      nodes.query_shape([1]),
      nodes.scene,
      nodes.filter_unique(2, [3]),
      nodes.relate_filter_unique(3,'',[4]),
      nodes.query_shape([5]),
      nodes.equal_shape([2,6])
    ],
    "params": params_types.ooro,
    "constraints": [
      nodes.out_neq([1,5]),
      nodes.null_s(),
      nodes.null_s(3)
    ]
  },
  {
    "text": [
      "Is the shape of the <Z2> <C2> <M2> <S2> [that is] <R> the <Z> <C> <M> <S> the same as the <Z4> <C4> <M4> <S4> [that is] <R2> the <Z3> <C3> <M3> <S3>?",
      "Does the <Z2> <C2> <M2> <S2> [that is] <R> the <Z> <C> <M> <S> have the same shape as the <Z4> <C4> <M4> <S4> [that is] <R2> the <Z3> <C3> <M3> <S3>?",
      "Do the <Z2> <C2> <M2> <S2> [that is] <R> the <Z> <C> <M> <S> and the <Z4> <C4> <M4> <S4> [that is] <R2> the <Z3> <C3> <M3> <S3> have the same shape?",
      "There is a <Z2> <C2> <M2> <S2> [that is] <R> the <Z> <C> <M> <S>; does it have the same shape as the <Z4> <C4> <M4> <S4> [that is] <R2> the <Z3> <C3> <M3> <S3>?",
      "There is a <Z2> <C2> <M2> <S2> [that is] <R> the <Z> <C> <M> <S>; is its shape the same as the <Z4> <C4> <M4> <S4> [that is] <R2> the <Z3> <C3> <M3> <S3>?",
      "There is a <Z2> <C2> <M2> <S2> [that is] <R> the <Z> <C> <M> <S>; is it the same shape as the <Z4> <C4> <M4> <S4> [that is] <R2> the <Z3> <C3> <M3> <S3>?"
    ],
    "query": fragement3('shape'),
    "query2": [
      "MATCH (i)~[:contains]~~<o<S>{<Z><C><M>}>, (i)~[:contains]~~<o2<S2>{<Z2><C2><M2>}>~~[<R>]~<o>",
      "WITH i, o2",
      "MATCH (i)~[:contains]~~<o3<S3>{<Z3><C3><M3>}>, (i)~[:contains]~~<o4<S4>{<Z4><C4><M4>}>~~[<R2>]~<o3>",
      "RETURN labels(o2) = labels(o4) as same"],
    "nodes": [
      nodes.scene,
      nodes.filter_unique(),
      nodes.relate_filter_unique(2,'',[1]),
      nodes.query_shape([2]),
      nodes.scene,
      nodes.filter_unique(3,[4]),
      nodes.relate_filter_unique(4,2,[5]),
      nodes.query_shape([6]),
      nodes.equal_shape([3,7])
    ],
    "params": params_types.orooro,
    "constraints": [
      nodes.out_neq([2,6]),
      nodes.null_s(2),
      nodes.null_s(4)
    ]
  }
]