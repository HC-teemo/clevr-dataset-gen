local side_inputs(id='', r='', with_r=false) = (if with_r then ["<R"+r+">"] else []) + [
  "<Z"+id+">",
  "<C"+id+">",
  "<M"+id+">",
  "<S"+id+">"
];
local node(type, side, inputs=[0]) = {
  "side_inputs": side,
  "inputs": inputs,
  "type": type
};
local base(type, id, inputs=[0])= {
  "side_inputs": side_inputs(id),
  "inputs": inputs,
  "type": type
};
local query_base(type, inputs=[0]) = {
  "inputs": inputs,
  "type": type
};
local constraint(params, type) = {
  "params": params,
  "type": type
};
local cons_null(var) = constraint(["<"+var+">"], "NULL");

{
    scene: {
        "inputs": [],
        "type": "scene"
    },
    filter(id='', inputs=[0]): base('filter', id, inputs),
    filter_count(id='', inputs=[0]): base('filter_count', id, inputs),

    filter_color(id='', inputs=[0]): node('filter_color', ["<C"+id+">"], inputs),
    filter_size(id='', inputs=[0]): node('filter_size', ["<Z"+id+">"], inputs),
    filter_shape(id='', inputs=[0]): node('filter_shape', ["<S"+id+">"], inputs),
    filter_material(id='', inputs=[0]): node('filter_material', ["<M"+id+">"], inputs),

    filter_exist(id='', inputs=[0]): base('filter_exist', id, inputs),
    filter_unique(id='', inputs=[0]): base('filter_unique', id, inputs),
    relate_filter(id='', rid='', inputs=[0]): {
      "side_inputs": side_inputs(id, rid, true),
      "inputs": inputs,
      "type": 'relate_filter'
    },
    relate_filter_count(id='', rid='', inputs=[0]): {
      "side_inputs": side_inputs(id, rid, true),
      "inputs": inputs,
      "type": 'relate_filter_count'
    },
    relate_filter_unique(id='', rid='', inputs=[0]): {
      "side_inputs": side_inputs(id, rid, true),
      "inputs": inputs,
      "type": 'relate_filter_unique'
    },
    relate_filter_exist(id='', rid='', inputs=[0]): {
      "side_inputs": side_inputs(id, rid, true),
      "inputs": inputs,
      "type": 'relate_filter_exist'
    },
    query_shape(inputs=[1]): query_base('query_shape', inputs),
    query_material(inputs=[1]): query_base('query_material', inputs),
    query_color(inputs=[1]): query_base('query_color', inputs),
    query_size(inputs=[1]): query_base('query_size', inputs),
    
    equal_size(inputs=[0]): query_base('equal_size', inputs),
    equal_color(inputs=[0]): query_base('equal_color', inputs),
    equal_material(inputs=[0]): query_base('equal_material', inputs),
    equal_shape(inputs=[0]): query_base('equal_shape', inputs),
    
    equal_integer(inputs=[0]): query_base('equal_integer', inputs),
    less_than(inputs=[0]): query_base('less_than', inputs),
    greater_than(inputs=[0]): query_base('greater_than', inputs),
    
    same_size(inputs=[0]): query_base('same_size', inputs),
    same_color(inputs=[0]): query_base('same_color', inputs),
    same_material(inputs=[0]): query_base('same_material', inputs),
    same_shape(inputs=[0]): query_base('same_shape', inputs),
    
    
    count(inputs=[0]): query_base('count', inputs),
    exist(inputs=[0]): query_base('exist', inputs),
    intersect(inputs=[0]): query_base('intersect', inputs),
    union(inputs=[0]): query_base('union', inputs),
    relate(rid='', inputs=[0]): {
      "side_inputs": ["<R"+rid+">"], 
      "inputs": inputs, 
      "type": "relate"
      },
    
    // constraints
    null_s(id=''): cons_null('S'+id),
    null_c(id=''): cons_null('C'+id),
    null_m(id=''): cons_null('M'+id),
    null_z(id=''): cons_null('Z'+id),
    out_neq(params): constraint(params, 'OUT_NEQ'),
    
}