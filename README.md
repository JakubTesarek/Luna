Luna
===========
Luna is simple OOP library for Lua.

Usage
===========
All you have to do in order to use Luna is to include it in your files:

```lua
    require "luna"
```

This will create global variable called Object. Object is a class describing common behavior of all objects. There is some inner login which you don't have to worry about.

Inheritance
=====
Do you want to create new class? It's easy:

```lua
    require "luna"

    Account = Object:extend {
        balance = 0,
    
        withdraw = function(self, amount)
            self.balance = self.balance - amount
        end

        deposit = function(self, amount)
            self.balance = self.balance + amount
        end
    }
```

We create new class that will be stored in Account variable. Remember - all classes are also objects so you have to store them somewhere.

`Extend()` takes one parameter which is a object or a table, if you want. This object defines how new created class will differ from extended class.

At this point you can start calling methods on Account but you probably don't want to because it will change the class definition. Creating new instance of Account will be much better idea.

Creating new instance
=====
Lets create a new instance

```lua
    require 'luna'

    -- account class definition skipped

    myAccount = Account:new();
```

And here you go. Now you've created new instance of Account and stored it into myAccount. You can call `new()` as many times you want, it will return new instance the same you are used from other languages.

Initializing
=====
But purpose of constructor is to initialize default values, maybe do some state validation etc. so how do you do that? Never change the `new()` function, it can break everything. Use `init()` instead. `Init()` is called automatically after instance is created and you can use this function to do whatever you want.

```lua
    require 'luna'

    Account = Object:extend {
        balance = 0,
   
        init = function(self, initialBalance)
            self.balance = balance
        end
 
        withdraw = function(self, v)
            self.balance = self.balance - v
        end

        deposit = function(self, v)
            self.balance = self.balance + v
        end
    }

    myAccount = Account:new(10000);
```

We've added `init()` definition to Account so when you call `Account:new()` with a parameter, it will be set as initial balance. `Init()` can have as many parameters you need and you can also use variable number of parameters `(...)`.

Super
=====
Now we want to create new account type called PersonalAccount that will store information about the owner. But we don't want to edit Account class (so I will omit it's definition in examples).

```lua
    require 'luna'

    -- account class definition skipped

    PersonalAccount = Account:extend {
        ownerName = '',

        init = function(self, ownerName)
            self.ownerName = ownerName;
        end
    }

    myPersonalAccount = PersonalAccount:new('Jakub Tesarek');
```

PersonalAccount will inherit behavior from Account so we don't need to copy-paste methods and attributes around. We just define what's different. But as you can see, we just rewrote the init() function so PersonalAccount will have no initial balance. We can of course copy body of `init()` function from parent class but Luna provides a better way.

```lua
    require 'luna'

    PersonalAccount = Account:extend {
        ownerName = '',

        init = function(self, ownerName, initialBalance)
            self.super:init(initialBalance);
            self.ownerName = ownerName;
        end
    }

    myPersonalAccount = PersonalAccount:new('Jakub Tesarek', 1000.00);
```

Magic. Every class has attribute that stores super class. You can call superclass's `init()` and don't have to care about what it does. If the super class also calls super `init()`, it will cascade up and every class will initialize the instance as needed.

It's good practice to call `self.super:init()` as first will thing in `init()` because the super class may rewrite whatever you've just set.