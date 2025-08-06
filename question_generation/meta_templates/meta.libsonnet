local optional = ' OPTIONAL ';
local match = ' MATCH ';
local where = ' WHERE ';
local with = ' WITH ';
local return = ' RETURN ';
local limit(num) =  ' LIMIT ' + num;
local as = ' AS ';

local e = {
  contains: '[:contains]'
};
local shape = 'shape';
local image = '(i)';
local dic = 'distinct';
local i = 'i';
local obs = 'objects';
local coll = 'collect(objects) AS objects';
local o= 'o';
local o2= 'o2';
local o3= 'o3';
local o4= 'o4';
local r = '[<R>]';
local r2 = '[<R2>]';

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
local _v_prop(var,prop)= if prop=='' then var else (if prop==shape then 'labels(%s)[0]'%var else '%s.%s'%[var, prop]);

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
    match_all(var): match + _tripet(image, e.contains, _object(var[1:])), // MATCH (i)~[:contains]~~<o>
    tripet_filter(var): _tripet(image, e.contains, _object_filter(var[1:])), // (i)~[:contains]~~<o<S>{<Z><C><M>}>
    match_filter(var): match + self.tripet_filter(var), // MATCH (i)~[:contains]~~<o<S>{<Z><C><M>}>
    match_one(var): match + _object_filter(var[1:]),
    return_count(var): _return([_countAs(var)]), // RETURN count(o) as count
    exist(var): with + var + limit(1) + return + _item(_count(var), '>0', 'exist'), // WITH o LIMIT 1 RETURN count(o) > 0 as exist
    return_shape(var): _return([_item('labels(%s)[0]'%var, '', 'shape')]), //labels(o)[0] as shape
    return_prop(var, prop): _return([_item(_v_prop(var, prop),'', prop)]),
    return_material(var): self.return_prop(var, 'material'), //RETURN o.material as material"
    return_color(var): self.return_prop(var, 'color'),
    return_size(var): self.return_prop(var, 'size'),
    filter_in(vars, list): std.join(' AND ', [v+' IN '+list for v in vars]),
    obj_r_obj(var,r,var2, out=true): _tripet(_object_filter(var[1:]), r, _object_filter(var2[1:]), out),
    match_oro(var,r,var2, out=true): match + self.obj_r_obj(var, r, var2, out),
    where_in_obs(vars): where + self.filter_in(vars, obs),
    where_eq(var1, var2, prop): where + _v_prop(var1, prop) + '=' + _v_prop(var2, prop),
    where_neq(var1, var2, prop): where + _v_prop(var1, prop) + '<>' + _v_prop(var2, prop),
    r_obj(r, var2, out=true): _tripet('', r, _object_filter(var2[1:]), out),
//
    match_all_and: self.match_all(obs) + _with([i, coll]),
    oro: self.match_filter(o) + ',' + self.tripet_filter(o2) + self.r_obj(r, o, false),
    orooro: 
      self.match_all_and +  
      self.match_oro(o, r, o2) + self.where_in_obs([o,o2]) + _with([i, obs, o2]) +
      self.match_oro(o3, r2, o4) + self.where_in_obs([o3,o4]) + _with([o2, o4]),
    same(var1, var2, prop): _return([_item(_v_prop(var1, prop),'='+ _v_prop(var2, prop), 'same')]),
  },
  query_funcs: {
    optional: optional,
    object_filter(var): _object_filter(var[1:]),
    with: _with,
    match: match,
    return: _return,
    where(w): where + w,
    item: _item,
    count: _count,
    countD(var): 'count(DISTINCT %s)'%var,
    countAs: _countAs,
    v_prop: _v_prop,
    coll: coll,
    _: ',',
  }
}