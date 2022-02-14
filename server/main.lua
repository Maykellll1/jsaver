function Create(key)
    return X.Create(key)
end

function Load(key)
    return X.Load(key)
end

function Save(key, data)
    return X.Save(key, data)
end

function Get(key)
    return X.Get(key)
end

function Set(key, data)
    return X.Set(key, data)
end

function Exists(key)
    return X.Exists(key)
end

function Erase(key)
    return X.Erase(key)
end

--Autosaver every one minute
Citizen.CreateThread(function()
    while true do
        for i,v in pairs(X.Data) do
            if X.Changed[i] then
                X.Save(i)
                X.Changed[i] = false
            end
        end
        Citizen.Wait(60000)
    end
end)