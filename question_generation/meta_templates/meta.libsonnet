local optional = ' OPTIONAL ';
local match = ' MATCH ';
local where = ' WHERE ';
local with = ' WITH ';
local return = ' RETURN ';
local limit(num) =  ' LIMIT ' + num;
local as = ' AS ';

local i = '(i)';
local e = {
  contains: '[:contains]'
};

local _object_filter(id = '') = '<o%s<S%s>{<Z%s><C%s><M%s>}>' % [id, id, id, id, id];
local _object(id = '') = '<o'+id+'>';

local _out(e, t) = '~' + e + '~~' + t;
local _in(e, t)  = '~~' + e + '~' + t;
local _expand(out=true) = if out then _out else _in;
local _tripet(s, e, t, out = true) = s + _expand(out)(e, t);

local _item(var, pred='', alias='') = var + pred + (if alias=='' then '' else as) + alias;
local _count(var) = 'count(%s)'%var;
local _countAs(var) = _item(_count(var), '', 'count' + var);
local _with(items) = with + std.join(',', items);
local _return(items) = return + std.join(',', items);
local params = {
  Z(id): {
    "type": "Size",
    "name": "<Z"+id+">"
  },
  C(id): {
    "type": "Color",
    "name": "<C"+id+">"
  },
  M(id): {
    "type": "Material",
    "name": "<M"+id+">"
  },
  S(id): {
    "type": "Shape",
    "name": "<S"+id+">"
  },
  R(id): {
    "type": "Relation",
    "name": "<R"+id+">"
  }
};


{
  params_types: {
    all_props(id=''): [params.Z(id), params.C(id), params.M(id), params.S(id)],
    o: self.all_props(),
    oo: self.all_props() + self.all_props(2),
    ooo: self.all_props() + self.all_props(2) + self.all_props(3),
    oro: self.all_props() + self.r() +  self.all_props(2),
    oroo: self.all_props() + self.r() +  self.all_props(2) + self.all_props(3),
    ooro: self.all_props() +  self.all_props(2) + self.r() + self.all_props(3),
    ororo: self.all_props() +  self.r() + self.all_props(2) + self.r(2) + self.all_props(3),
    orooro: self.all_props() + self.r() +  self.all_props(2) + self.all_props(3) + self.r(2)  + self.all_props(4),
    r(id=''): [params.R(id)]
  },
  query_frags: {
    match_all(var): match + _tripet(i, e.contains, _object(var[1:])), // MATCH (i)~[:contains]~~<o>
    match_filter(var): match + _tripet(i, e.contains, _object_filter(var[1:])), // MATCH (i)~[:contains]~~<o<S>{<Z><C><M>}>
    match_one(id): match + _object_filter(id),
    return_count(var): _return([_countAs(var)]), // RETURN count(o) as count
    exist(var): with + var + limit(1) + return + _item(_count(var), '>0', 'exist'), // WITH o LIMIT 1 RETURN count(o) > 0 as exist
    return_shape(var): _return([_item('labels(%s)[0]'%var, '', 'shape')]), //labels(o)[0] as shape
    return_prop(var, prop): _return([_item(var, '.'+prop, prop)]),
    return_material(var): self.return_prop(var, 'material'), //RETURN o.material as material"
    return_color(var): self.return_prop(var, 'color'),
    return_size(var): self.return_prop(var, 'size'),
    filter_in(vars, list): std.join(' AND ', [vars+' IN '+list for v in vars]),
    obj_r_obj(id,r,id2, out=true): _tripet(_object_filter(id), r, _object_filter(id), out),
  },
  query_funcs: {
    optional: optional,
    object_filter: _object_filter,
    with: _with,
    return: _return,
    item: _item,
    count: _count,
    countAs: _countAs,
  }
}