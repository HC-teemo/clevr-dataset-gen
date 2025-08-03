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
      "Are there any other things that have the same size as the <Z> <C> <M> <S>?",
      "Is there anything else that has the same size as the <Z> <C> <M> <S>?",
      "Is there any other thing that has the same size as the <Z> <C> <M> <S>?",
      "Are there any other things that are the same size as the <Z> <C> <M> <S>?",
      "Is there anything else that is the same size as the <Z> <C> <M> <S>?",
      "Is there any other thing that is the same size as the <Z> <C> <M> <S>?"
    ],
    "query": [
      "MATCH (i)~[:contains]~~<o<S>{<Z><C><M>}>, (i)~[:contains]~~<o2>",
      "WHERE o2.size = o.size",
      "WITH o2 LIMIT 1",
      "RETURN count(o2)>0 as exist"],
    "nodes": [
      nodes.scene,
      nodes.filter_unique(),
      nodes.same_size([1]),
      nodes.exist([2])
    ],
    "params": params_types.all_props(),
    "constraints": [
      nodes.null_z()
    ]
  },
  {
    "text": [
      "Are there any other things that have the same color as the <Z> <C> <M> <S>?",
      "Is there anything else that has the same color as the <Z> <C> <M> <S>?",
      "Is there any other thing that has the same color as the <Z> <C> <M> <S>?",
      "Are there any other things that are the same color as the <Z> <C> <M> <S>?",
      "Is there anything else that is the same color as the <Z> <C> <M> <S>?",
      "Is there any other thing that is the same color as the <Z> <C> <M> <S>?",
      "Are there any other things of the same color as the <Z> <C> <M> <S>?",
      "Is there anything else of the same color as the <Z> <C> <M> <S>?",
      "Is there any other thing of the same color as the <Z> <C> <M> <S>?"
    ],
    "query": [
      "MATCH (i)~[:contains]~~<o<S>{<Z><C><M>}>, (i)~[:contains]~~<o2>",
      "WHERE o2.color = o.color",
      "WITH o2 LIMIT 1",
      "RETURN count(o2)>0 as exist"],
    "nodes": [
      nodes.scene,
      nodes.filter_unique(),
      nodes.same_color([1]),
      nodes.exist([2])
    ],
    "params": params_types.all_props(),
    "constraints": [
      nodes.null_c()
    ]
  },
  {
    "text": [
      "Are there any other things that have the same material as the <Z> <C> <M> <S>?",
      "Is there anything else that has the same material as the <Z> <C> <M> <S>?",
      "Is there any other thing that has the same material as the <Z> <C> <M> <S>?",
      "Are there any other things that are [made of] the same material as the <Z> <C> <M> <S>?",
      "Is there anything else that is [made of] the same material as the <Z> <C> <M> <S>?",
      "Is there any other thing that is [made of] the same material as the <Z> <C> <M> <S>?"
    ],
    "query": [
      "MATCH (i)~[:contains]~~<o<S>{<Z><C><M>}>, (i)~[:contains]~~<o2>",
      "WHERE o2.material = o.material",
      "WITH o2 LIMIT 1",
      "RETURN count(o2)>0 as exist"],
    "nodes": [
      nodes.scene,
      nodes.filter_unique(),
      nodes.same_material([1]),
      nodes.exist([2])
    ],
    "params": params_types.all_props(),
    "constraints": [
      nodes.null_m()
    ]
  },
  {
    "text": [
      "Are there any other things that have the same shape as the <Z> <C> <M> <S>?",
      "Is there anything else that has the same shape as the <Z> <C> <M> <S>?",
      "Is there any other thing that has the same shape as the <Z> <C> <M> <S>?",
      "Are there any other things that are the same shape as the <Z> <C> <M> <S>?",
      "Is there anything else that is the same shape as the <Z> <C> <M> <S>?",
      "Is there any other thing that is the same shape as the <Z> <C> <M> <S>?"
    ],
    "query": [
      "MATCH (i)~[:contains]~~<o<S>{<Z><C><M>}>, (i)~[:contains]~~<o2>",
      "WHERE labels(o2) = labels(o)",
      "WITH o2 LIMIT 1",
      "RETURN count(o2)>0 as exist"],
    "nodes": [
      nodes.scene,
      nodes.filter_unique(),
      nodes.same_shape([1]),
      nodes.exist([2])
    ],
    "params": params_types.all_props(),
    "constraints": [
      nodes.null_s()
    ]
  },
  {
    "text": [
      "How many other things are the same size as the <Z> <C> <M> <S>?",
      "What number of other things are the same size as the <Z> <C> <M> <S>?",
      "How many other things are there of the same size as the <Z> <C> <M> <S>?",
      "What number of other things are there of the same size as the <Z> <C> <M> <S>?",
      "How many other objects are the same size as the <Z> <C> <M> <S>?",
      "What number of other objects are the same size as the <Z> <C> <M> <S>?",
      "How many other objects are there of the same size as the <Z> <C> <M> <S>?",
      "What number of other objects are there of the same size as the <Z> <C> <M> <S>?"
    ],
    "query": [
      "MATCH (i)~[:contains]~~<o<S>{<Z><C><M>}>, (i)~[:contains]~~<o2>",
      "WHERE o2.size = o.size",
      "RETURN count(o2) as count"],
    "nodes": [
      nodes.scene,
      nodes.filter_unique(),
      nodes.same_size([1]),
      nodes.count([2])
    ],
    "params": params_types.all_props(),
    "constraints": [
      nodes.null_z()
    ]
  },
  {
    "text": [
      "How many other things are the same color as the <Z> <C> <M> <S>?",
      "What number of other things are the same color as the <Z> <C> <M> <S>?",
      "How many other things are there of the same color as the <Z> <C> <M> <S>?",
      "What number of other things are there of the same color as the <Z> <C> <M> <S>?",
      "How many other objects are the same color as the <Z> <C> <M> <S>?",
      "What number of other objects are the same color as the <Z> <C> <M> <S>?",
      "How many other objects are there of the same color as the <Z> <C> <M> <S>?",
      "What number of other objects are there of the same color as the <Z> <C> <M> <S>?"
    ],
    "query": [
      "MATCH (i)~[:contains]~~<o<S>{<Z><C><M>}>, (i)~[:contains]~~<o2>",
      "WHERE o2.color = o.color",
      "RETURN count(o2) as count"],
    "nodes": [
      nodes.scene,
      nodes.filter_unique(),
      nodes.same_color([1]),
      nodes.count([2])
    ],
    "params": params_types.all_props(),
    "constraints": [
      nodes.null_c()
    ]
  },
  {
    "text": [
      "What number of other things are [made of] the same material as the <Z> <C> <M> <S>?",
      "How many other things are [made of] the same material as the <Z> <C> <M> <S>?",
      "How many other things are there of the same material as the <Z> <C> <M> <S>?",
      "What number of other things are there of the same material as the <Z> <C> <M> <S>",
      "How many other objects are the same material as the <Z> <C> <M> <S>?",
      "What number of other objects are the same material as the <Z> <C> <M> <S>?",
      "How many other objects are there of the same material as the <Z> <C> <M> <S>?",
      "What number of other objects are there of the same material as the <Z> <C> <M> <S>?"
    ],
    "query": [
      "MATCH (i)~[:contains]~~<o<S>{<Z><C><M>}>, (i)~[:contains]~~<o2>",
      "WHERE o2.material = o.material",
      "RETURN count(o2) as count"],
    "nodes": [
      nodes.scene,
      nodes.filter_unique(),
      nodes.same_material([1]),
      nodes.count([2])
    ],
    "params": params_types.all_props(),
    "constraints": [
      nodes.null_m()
    ]
  },
  {
    "text": [
      "How many other things are the same shape as the <Z> <C> <M> <S>?",
      "What number of other things are the same shape as the <Z> <C> <M> <S>?",
      "How many other things are there of the same shape as the <Z> <C> <M> <S>?",
      "What number of other things are there of the same shape as the <Z> <C> <M> <S>?",
      "How many other objects are the same shape as the <Z> <C> <M> <S>?",
      "What number of other objects are the same shape as the <Z> <C> <M> <S>?",
      "How many other objects are there of the same shape as the <Z> <C> <M> <S>?",
      "What number of other objects are there of the same shape as the <Z> <C> <M> <S>?"
    ],
    "query": [
      "MATCH (i)~[:contains]~~<o<S>{<Z><C><M>}>, (i)~[:contains]~~<o2>",
      "WHERE labels(o2) = labels(o)",
      "RETURN count(o2) as count"],
    "nodes": [
      nodes.scene,
      nodes.filter_unique(),
      nodes.same_shape([1]),
      nodes.count([2])
    ],
    "params": params_types.all_props(),
    "constraints": [
      nodes.null_s()
    ]
  },
  {
    "text": [
      "Are there any other <Z2> <C2> <M2> <S2>s that have the same size as the <Z> <C> <M> <S>?",
      "Is there another <Z2> <C2> <M2> <S2> that has the same size as the <Z> <C> <M> <S>?",
      "Are there any other <Z2> <C2> <M2> <S2>s of the same size as the <Z> <C> <M> <S>?",
      "Is there another <Z2> <C2> <M2> <S2> of the same size as the <Z> <C> <M> <S>?"
    ],
    "query": [
      "MATCH (i)~[:contains]~~<o<S>{<Z><C><M>}>, (i)~[:contains]~~<o2<S2>{<Z2><C2><M2>}>",
      "WHERE o2.size = o.size AND o2 <> o",
      "WITH o2 LIMIT 1",
      "RETURN count(o2)>0 as exist"],
    "nodes": [
      nodes.scene,
      nodes.filter_unique(),
      nodes.same_size([1]),
      nodes.filter_exist(2, [2])
    ],
    "params": params_types.all_props() + params_types.all_props(2),
    "constraints": [
      nodes.null_z(),
      nodes.null_z(2)
    ]
  },
  {
    "text": [
      "Are there any other <Z2> <C2> <M2> <S2>s that have the same color as the <Z> <C> <M> <S>?",
      "Is there another <Z2> <C2> <M2> <S2> that has the same color as the <Z> <C> <M> <S>?",
      "Are there any other <Z2> <C2> <M2> <S2>s of the same color as the <Z> <C> <M> <S>?",
      "Is there another <Z2> <C2> <M2> <S2> of the same color as the <Z> <C> <M> <S>?"
    ],
    "query": [
      "MATCH (i)~[:contains]~~<o<S>{<Z><C><M>}>, (i)~[:contains]~~<o2<S2>{<Z2><C2><M2>}>",
      "WHERE o2.color = o.color AND o2 <> o",
      "WITH o2 LIMIT 1",
      "RETURN count(o2)>0 as exist"],
    "nodes": [
      nodes.scene,
      nodes.filter_unique(),
      nodes.same_color([1]),
      nodes.filter_exist(2, [2])
    ],
    "params": params_types.all_props() + params_types.all_props(2),
    "constraints": [
      nodes.null_c(),
      nodes.null_c(2)
    ]
  },
  {
    "text": [
      "Are there any other <Z2> <C2> <M2> <S2>s that have the same material as the <Z> <C> <M> <S>?",
      "Is there another <Z2> <C2> <M2> <S2> that has the same material as the <Z> <C> <M> <S>?",
      "Are there any other <Z2> <C2> <M2> <S2>s made of the same material as the <Z> <C> <M> <S>?",
      "Is there another <Z2> <C2> <M2> <S2> made of the same material as the <Z> <C> <M> <S>?"
    ],
    "query": [
      "MATCH (i)~[:contains]~~<o<S>{<Z><C><M>}>, (i)~[:contains]~~<o2<S2>{<Z2><C2><M2>}>",
      "WHERE o2.material = o.material AND o2 <> o",
      "WITH o2 LIMIT 1",
      "RETURN count(o2)>0 as exist"],
    "nodes": [
      nodes.scene,
      nodes.filter_unique(),
      nodes.same_material([1]),
      nodes.filter_exist(2, [2])
    ],
    "params": params_types.all_props() + params_types.all_props(2),
    "constraints": [
      nodes.null_m(),
      nodes.null_m(2)
    ]
  },
  {
    "text": [
      "Are there any other <Z2> <C2> <M2> <S2>s that have the same shape as the <Z> <C> <M> <S>?",
      "Is there another <Z2> <C2> <M2> <S2> that has the same shape as the <Z> <C> <M> <S>?",
      "Are there any other <Z2> <C2> <M2> <S2>s of the same shape as the <Z> <C> <M> <S>?",
      "Is there another <Z2> <C2> <M2> <S2> of the same shape as the <Z> <C> <M> <S>?"
    ],
    "query": [
      "MATCH (i)~[:contains]~~<o<S>{<Z><C><M>}>, (i)~[:contains]~~<o2<S2>{<Z2><C2><M2>}>",
      "WHERE labels(o2) = labels(o) AND o2 <> o",
      "WITH o2 LIMIT 1",
      "RETURN count(o2)>0 as exist"],
    "nodes": [
      nodes.scene,
      nodes.filter_unique(),
      nodes.same_shape([1]),
      nodes.filter_exist(2, [2])
    ],
    "params": params_types.all_props() + params_types.all_props(2),
    "constraints": [
      nodes.null_s(),
      nodes.null_s(2)
    ]
  },
  {
    "text": [
      "How many other <Z2> <C2> <M2> <S2>s have the same size as the <Z> <C> <M> <S>?",
      "How many other <Z2> <C2> <M2> <S2>s are the same size as the <Z> <C> <M> <S>?",
      "What number of other <Z2> <C2> <M2> <S2>s have the same size as the <Z> <C> <M> <S>?",
      "What number of other <Z2> <C2> <M2> <S2>s are the same size as the <Z> <C> <M> <S>?"
    ],
    "query": [
      "MATCH (i)~[:contains]~~<o<S>{<Z><C><M>}>, (i)~[:contains]~~<o2<S2>{<Z2><C2><M2>}>",
      "WHERE o2.size = o.size AND o2 <> o",
      "RETURN count(o2) as count"],
    "nodes": [
      nodes.scene,
      nodes.filter_unique(),
      nodes.same_size([1]),
      nodes.filter_count(2, [2])
    ],
    "params": params_types.all_props() + params_types.all_props(2),
    "constraints": [
      nodes.null_z(),
      nodes.null_z(2)
    ]
  },
  {
    "text": [
      "How many other <Z2> <C2> <M2> <S2>s have the same color as the <Z> <C> <M> <S>?",
      "How many other <Z2> <C2> <M2> <S2>s are the same color as the <Z> <C> <M> <S>?",
      "What number of other <Z2> <C2> <M2> <S2>s have the same color as the <Z> <C> <M> <S>?",
      "What number of other <Z2> <C2> <M2> <S2>s are the same color as the <Z> <C> <M> <S>?"
    ],
    "query": [
      "MATCH (i)~[:contains]~~<o<S>{<Z><C><M>}>, (i)~[:contains]~~<o2<S2>{<Z2><C2><M2>}>",
      "WHERE o2.color = o.color AND o2 <> o",
      "RETURN count(o2) as count"],
    "nodes": [
      nodes.scene,
      nodes.filter_unique(),
      nodes.same_color([1]),
      nodes.filter_count(2, [2])
    ],
    "params": params_types.all_props() + params_types.all_props(2),
    "constraints": [
      nodes.null_c(),
      nodes.null_c(2)
    ]
  },
  {
    "text": [
      "How many other <Z2> <C2> <M2> <S2>s have the same material as the <Z> <C> <M> <S>?",
      "What number of other <Z2> <C2> <M2> <S2>s have the same material as the <Z> <C> <M> <S>?",
      "What number of other <Z2> <C2> <M2> <S2>s are [made of] the same material as the <Z> <C> <M> <S>?",
      "How many other <Z2> <C2> <M2> <S2>s are [made of] the same material as the <Z> <C> <M> <S>?"
    ],
    "query": [
      "MATCH (i)~[:contains]~~<o<S>{<Z><C><M>}>, (i)~[:contains]~~<o2<S2>{<Z2><C2><M2>}>",
      "WHERE o2.material = o.material AND o2 <> o",
      "RETURN count(o2) as count"],
    "nodes": [
      nodes.scene,
      nodes.filter_unique(),
      nodes.same_material([1]),
      nodes.filter_count(2, [2])
    ],
    "params": params_types.all_props() + params_types.all_props(2),
    "constraints": [
      nodes.null_m(),
      nodes.null_m(2)
    ]
  },
  {
    "text": [
      "How many other <Z2> <C2> <M2> <S2>s have the same shape as the <Z> <C> <M> <S>?",
      "What number of other <Z2> <C2> <M2> <S2>s have the same shape as the <Z> <C> <M> <S>?",
      "What number of other <Z2> <C2> <M2> <S2>s are the same shape as the <Z> <C> <M> <S>?",
      "How many other <Z2> <C2> <M2> <S2>s are the same shape as the <Z> <C> <M> <S>?"
    ],
    "query": [
      "MATCH (i)~[:contains]~~<o<S>{<Z><C><M>}>, (i)~[:contains]~~<o2<S2>{<Z2><C2><M2>}>",
      "WHERE labels(o2) = labels(o) AND o2 <> o",
      "RETURN count(o2) as count"],
    "nodes": [
      nodes.scene,
      nodes.filter_unique(),
      nodes.same_shape([1]),
      nodes.filter_count(2, [2])
    ],
    "params": params_types.all_props() + params_types.all_props(2),
    "constraints": [
      nodes.null_s(),
      nodes.null_s(2)
    ]
  },
  {
    "text": [
      "What color is the other <Z2> <C2> <M2> <S2> that is the same size as the <Z> <C> <M> <S>?",
      "What is the color of the other <Z2> <C2> <M2> <S2> that is the same size as the <Z> <C> <M> <S>?",
      "The other <Z2> <C2> <M2> <S2> that is the same size as the <Z> <C> <M> <S> is what color?",
      "There is another <Z2> <C2> <M2> <S2> that is the same size as the <Z> <C> <M> <S>; what color is it?",
      "There is another <Z2> <C2> <M2> <S2> that is the same size as the <Z> <C> <M> <S>; what is its color?"
    ],
    "query": [
      "MATCH (i)~[:contains]~~<o<S>{<Z><C><M>}>, (i)~[:contains]~~<o2<S2>{<Z2><C2><M2>}>",
      "WHERE o2.size = o.size AND o2 <> o",
      "RETURN o2.color as color"],
    "nodes": [
      nodes.scene,
      nodes.filter_unique(),
      nodes.same_size([1]),
      nodes.filter_unique(2, [2]),
      nodes.query_color([3])
    ],
    "params": params_types.all_props() + params_types.all_props(2),
    "constraints": [
      nodes.null_z(),
      nodes.null_z(2),
      nodes.null_c(2)
    ]
  },
  {
    "text": [
      "What material is the other <Z2> <C2> <M2> <S2> that is the same size as the <Z> <C> <M> <S>?",
      "What is the material of the other <Z2> <C2> <M2> <S2> that is the same size as the <Z> <C> <M> <S>?",
      "There is another <Z2> <C2> <M2> <S2> that is the same size as the <Z> <C> <M> <S>; what material is it?",
      "There is another <Z2> <C2> <M2> <S2> that is the same size as the <Z> <C> <M> <S>; what is its material?",
      "There is another <Z2> <C2> <M2> <S2> that is the same size as the <Z> <C> <M> <S>; what is it made of?"
    ],
    "query": [
      "MATCH (i)~[:contains]~~<o<S>{<Z><C><M>}>, (i)~[:contains]~~<o2<S2>{<Z2><C2><M2>}>",
      "WHERE o2.size = o.size AND o2 <> o",
      "RETURN o2.material as material"],
    "nodes": [
      nodes.scene,
      nodes.filter_unique(),
      nodes.same_size([1]),
      nodes.filter_unique(2, [2]),
      nodes.query_material([3])
    ],
    "params": params_types.all_props() + params_types.all_props(2),
    "constraints": [
      nodes.null_z(),
      nodes.null_z(2),
      nodes.null_m(2)
    ]
  },
  {
    "text": [
      "What shape is the other <Z2> <C2> <M2> <S2> that is the same size as the <Z> <C> <M> <S>?",
      "What is the shape of the other <Z2> <C2> <M2> <S2> that is the same size as the <Z> <C> <M> <S>?",
      "The other <Z2> <C2> <M2> <S2> that is the same size as the <Z> <C> <M> <S> is what shape?",
      "There is another <Z2> <C2> <M2> <S2> that is the same size as the <Z> <C> <M> <S>; what shape is it?",
      "There is another <Z2> <C2> <M2> <S2> that is the same size as the <Z> <C> <M> <S>; what is its shape?"
    ],
    "query": [
      "MATCH (i)~[:contains]~~<o<S>{<Z><C><M>}>, (i)~[:contains]~~<o2<S2>{<Z2><C2><M2>}>",
      "WHERE o2.size = o.size AND o2 <> o",
      "RETURN labels(o2)[0] as shape"],
    "nodes": [
      nodes.scene,
      nodes.filter_unique(),
      nodes.same_size([1]),
      nodes.filter_unique(2, [2]),
      nodes.query_shape([3])
    ],
    "params": params_types.all_props() + params_types.all_props(2),
    "constraints": [
      nodes.null_z(),
      nodes.null_z(2),
      nodes.null_s(2)
    ]
  },
  {
    "text": [
      "What size is the other <Z2> <C2> <M2> <S2> that is the same color as the <Z> <C> <M> <S>?",
      "What is the size of the other <Z2> <C2> <M2> <S2> that is the same color as the <Z> <C> <M> <S>?",
      "The other <Z2> <C2> <M2> <S2> that is the same color as the <Z> <C> <M> <S> is what size?",
      "There is another <Z2> <C2> <M2> <S2> that is the same color as the <Z> <C> <M> <S>; what size is it?",
      "There is another <Z2> <C2> <M2> <S2> that is the same color as the <Z> <C> <M> <S>; what is its size?"
    ],
    "query": [
      "MATCH (i)~[:contains]~~<o<S>{<Z><C><M>}>, (i)~[:contains]~~<o2<S2>{<Z2><C2><M2>}>",
      "WHERE o2.color = o.color AND o2 <> o",
      "RETURN o2.size as size"],
    "nodes": [
      nodes.scene,
      nodes.filter_unique(),
      nodes.same_color([1]),
      nodes.filter_unique(2, [2]),
      nodes.query_size([3])
    ],
    "params": params_types.all_props() + params_types.all_props(2),
    "constraints": [
      nodes.null_c(),
      nodes.null_c(2),
      nodes.null_z(2)
    ]
  },
  {
    "text": [
      "What material is the other <Z2> <C2> <M2> <S2> that is the same color as the <Z> <C> <M> <S>?",
      "What is the material of the other <Z2> <C2> <M2> <S2> that is the same color as the <Z> <C> <M> <S>?",
      "There is another <Z2> <C2> <M2> <S2> that is the same color as the <Z> <C> <M> <S>; what material is it?",
      "There is another <Z2> <C2> <M2> <S2> that is the same color as the <Z> <C> <M> <S>; what is its material?",
      "There is another <Z2> <C2> <M2> <S2> that is the same color as the <Z> <C> <M> <S>; what is it made of?"
    ],
    "query": [
      "MATCH (i)~[:contains]~~<o<S>{<Z><C><M>}>, (i)~[:contains]~~<o2<S2>{<Z2><C2><M2>}>",
      "WHERE o2.color = o.color AND o2 <> o",
      "RETURN o2.material as material"],
    "nodes": [
      nodes.scene,
      nodes.filter_unique(),
      nodes.same_color([1]),
      nodes.filter_unique(2, [2]),
      nodes.query_material([3])
    ],
    "params": params_types.all_props() + params_types.all_props(2),
    "constraints": [
      nodes.null_c(),
      nodes.null_c(2),
      nodes.null_m(2)
    ]
  },
  {
    "text": [
      "What shape is the other <Z2> <C2> <M2> <S2> that is the same color as the <Z> <C> <M> <S>?",
      "What is the shape of the other <Z2> <C2> <M2> <S2> that is the same color as the <Z> <C> <M> <S>?",
      "The other <Z2> <C2> <M2> <S2> that is the same color as the <Z> <C> <M> <S> is what shape?",
      "There is another <Z2> <C2> <M2> <S2> that is the same color as the <Z> <C> <M> <S>; what shape is it?",
      "There is another <Z2> <C2> <M2> <S2> that is the same color as the <Z> <C> <M> <S>; what is its shape?"
    ],
    "query": [
      "MATCH (i)~[:contains]~~<o<S>{<Z><C><M>}>, (i)~[:contains]~~<o2<S2>{<Z2><C2><M2>}>",
      "WHERE o2.color = o.color AND o2 <> o",
      "RETURN labels(o2)[0] as shape"],
    "nodes": [
      nodes.scene,
      nodes.filter_unique(),
      nodes.same_color([1]),
      nodes.filter_unique(2, [2]),
      nodes.query_shape([3])
    ],
    "params": params_types.all_props() + params_types.all_props(2),
    "constraints": [
      nodes.null_c(),
      nodes.null_c(2),
      nodes.null_s(2)
    ]
  },
  {
    "text": [
      "What size is the other <Z2> <C2> <M2> <S2> that is [made of] the same material as the <Z> <C> <M> <S>?",
      "What is the size of the other <Z2> <C2> <M2> <S2> that is [made of] the same material as the <Z> <C> <M> <S>?",
      "The other <Z2> <C2> <M2> <S2> that is [made of] the same material as the <Z> <C> <M> <S> is what size?",
      "There is another <Z2> <C2> <M2> <S2> that is [made of] the same material as the <Z> <C> <M> <S>; what is its size?",
      "There is another <Z2> <C2> <M2> <S2> that is [made of] the same material as the <Z> <C> <M> <S>; what size is it?"
    ],
    "query": [
      "MATCH (i)~[:contains]~~<o<S>{<Z><C><M>}>, (i)~[:contains]~~<o2<S2>{<Z2><C2><M2>}>",
      "WHERE o2.material = o.material AND o2 <> o",
      "RETURN o2.size as size"],
    "nodes": [
      nodes.scene,
      nodes.filter_unique(),
      nodes.same_material([1]),
      nodes.filter_unique(2, [2]),
      nodes.query_size([3])
    ],
    "params": params_types.all_props() + params_types.all_props(2),
    "constraints": [
      nodes.null_m(),
      nodes.null_m(2),
      nodes.null_z(2)
    ]
  },
  {
    "text": [
      "What color is the other <Z2> <C2> <M2> <S2> that is [made of] the same material as the <Z> <C> <M> <S>?",
      "What is the color of the other <Z2> <C2> <M2> <S2> that is [made of] the same material as the <Z> <C> <M> <S>?",
      "The other <Z2> <C2> <M2> <S2> that is [made of] the same material as the <Z> <C> <M> <S> is what color?",
      "There is another <Z2> <C2> <M2> <S2> that is [made of] the same material as the <Z> <C> <M> <S>; what is its color?",
      "There is another <Z2> <C2> <M2> <S2> that is [made of] the same material as the <Z> <C> <M> <S>; what color is it?"
    ],
    "query": [
      "MATCH (i)~[:contains]~~<o<S>{<Z><C><M>}>, (i)~[:contains]~~<o2<S2>{<Z2><C2><M2>}>",
      "WHERE o2.material = o.material AND o2 <> o",
      "RETURN o2.color as color"],
    "nodes": [
      nodes.scene,
      nodes.filter_unique(),
      nodes.same_material([1]),
      nodes.filter_unique(2, [2]),
      nodes.query_color([3])
    ],
    "params": params_types.all_props() + params_types.all_props(2),
    "constraints": [
      nodes.null_m(),
      nodes.null_m(2),
      nodes.null_c(2)
    ]
  },
  {
    "text": [
      "What shape is the other <Z2> <C2> <M2> <S2> that is [made of] the same material as the <Z> <C> <M> <S>?",
      "What is the shape of the other <Z2> <C2> <M2> <S2> that is [made of] the same material as the <Z> <C> <M> <S>?",
      "The other <Z2> <C2> <M2> <S2> that is [made of] the same material as the <Z> <C> <M> <S> is what shape?",
      "There is another <Z2> <C2> <M2> <S2> that is [made of] the same material as the <Z> <C> <M> <S>; what is its shape?",
      "There is another <Z2> <C2> <M2> <S2> that is [made of] the same material as the <Z> <C> <M> <S>; what shape is it?"
    ],
    "query": [
      "MATCH (i)~[:contains]~~<o<S>{<Z><C><M>}>, (i)~[:contains]~~<o2<S2>{<Z2><C2><M2>}>",
      "WHERE o2.material = o.material AND o2 <> o",
      "RETURN labels(o2)[0] as shape"],
    "nodes": [
      nodes.scene,
      nodes.filter_unique(),
      nodes.same_material([1]),
      nodes.filter_unique(2, [2]),
      nodes.query_shape([3])
    ],
    "params": params_types.all_props() + params_types.all_props(2),
    "constraints": [
      nodes.null_m(),
      nodes.null_m(2),
      nodes.null_s(2)
    ]
  },
  {
    "text": [
      "What size is the other <Z2> <C2> <M2> <S2> that is the same shape as the <Z> <C> <M> <S>?",
      "What is the size of the other <Z2> <C2> <M2> <S2> that is the same shape as the <Z> <C> <M> <S>?",
      "The other <Z2> <C2> <M2> <S2> that is the same shape as the <Z> <C> <M> <S> is what size?",
      "There is another <Z2> <C2> <M2> <S2> that is the same shape as the <Z> <C> <M> <S>; what size is it?",
      "There is another <Z2> <C2> <M2> <S2> that is the same shape as the <Z> <C> <M> <S>; what is its size?"
    ],
    "query": [
      "MATCH (i)~[:contains]~~<o<S>{<Z><C><M>}>, (i)~[:contains]~~<o2<S2>{<Z2><C2><M2>}>",
      "WHERE labels(o2) = labels(o) AND o2 <> o",
      "RETURN o2.size as size"],
    "nodes": [
      nodes.scene,
      nodes.filter_unique(),
      nodes.same_shape([1]),
      nodes.filter_unique(2, [2]),
      nodes.query_size([3])
    ],
    "params": params_types.all_props() + params_types.all_props(2),
    "constraints": [
      nodes.null_s(),
      nodes.null_s(2),
      nodes.null_z(2)
    ]
  },
  {
    "text": [
      "What color is the other <Z2> <C2> <M2> <S2> that is the same shape as the <Z> <C> <M> <S>?",
      "What is the color of the other <Z2> <C2> <M2> <S2> that is the same shape as the <Z> <C> <M> <S>?",
      "The other <Z2> <C2> <M2> <S2> that is the same shape as the <Z> <C> <M> <S> is what color?",
      "There is another <Z2> <C2> <M2> <S2> that is the same shape as the <Z> <C> <M> <S>; what color is it?",
      "There is another <Z2> <C2> <M2> <S2> that is the same shape as the <Z> <C> <M> <S>; what is its color?"
    ],
    "query": [
      "MATCH (i)~[:contains]~~<o<S>{<Z><C><M>}>, (i)~[:contains]~~<o2<S2>{<Z2><C2><M2>}>",
      "WHERE labels(o2) = labels(o) AND o2 <> o",
      "RETURN o2.color as color"],
    "nodes": [
      nodes.scene,
      nodes.filter_unique(),
      nodes.same_shape([1]),
      nodes.filter_unique(2, [2]),
      nodes.query_color([3])
    ],
    "params": params_types.all_props() + params_types.all_props(2),
    "constraints": [
      nodes.null_s(),
      nodes.null_s(2),
      nodes.null_c(2)
    ]
  },
  {
    "text": [
      "What material is the other <Z2> <C2> <M2> <S2> that is the same shape as the <Z> <C> <M> <S>?",
      "What is the material of the other <Z2> <C2> <M2> <S2> that is the same shape as the <Z> <C> <M> <S>?",
      "There is another <Z2> <C2> <M2> <S2> that is the same shape as the <Z> <C> <M> <S>; what material is it?",
      "There is another <Z2> <C2> <M2> <S2> that is the same shape as the <Z> <C> <M> <S>; what is its material?",
      "There is another <Z2> <C2> <M2> <S2> that is the same shape as the <Z> <C> <M> <S>; what is it made of?"
    ],
    "query": [
      "MATCH (i)~[:contains]~~<o<S>{<Z><C><M>}>, (i)~[:contains]~~<o2<S2>{<Z2><C2><M2>}>",
      "WHERE labels(o2) = labels(o) AND o2 <> o",
      "RETURN o2.material as material"],
    "nodes": [
      nodes.scene,
      nodes.filter_unique(),
      nodes.same_shape([1]),
      nodes.filter_unique(2, [2]),
      nodes.query_material([3])
    ],
    "params": params_types.all_props() + params_types.all_props(2),
    "constraints": [
      nodes.null_s(),
      nodes.null_s(2),
      nodes.null_m(2)
    ]
  }
]