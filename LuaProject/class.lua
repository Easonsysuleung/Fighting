function class(classname, super)
	local cls

	if super then
		if "userdata" == type(super) then
			cls = clone(super)
		else
			cls = cloneT(super)
		end
		cls.super = super
		cls.Ctor = function() end
	else
		cls = {Ctor = function() end}
	end

	cls.__cname = classname
	cls.__index = cls


	function cls.New(...)
		local instance = setmetatable({}, cls)
		local create
		create = function(c, ...)
			if c.super then
				create(c.super, ...)
			end
			if c.Ctor then
				c.Ctor(instance, ...)
			end
		end
		create(instance, ...)
		instance.class = cls

		return instance

	end

	return cls

end

print("Hello lua")