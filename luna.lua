Object = {
    extend = function(self, classObject)
        classObject = classObject or {}
        setmetatable(classObject, self)
        self.__index = self
        
        classObject.super = self
        
        return classObject
    end;
    
    new = function(self, ...)
        instance = {}
        setmetatable(instance, self)
        self.__index = self
        
        instance:init(unpack(arg))
        
        return instance
    end;
    
    init = function(self, ...) end
}