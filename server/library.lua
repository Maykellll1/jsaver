X = {}
X.Data = {}
X.Changed = {}

local function trim(s)
    return (s:gsub("^%s*(.-)%s*$", "%1"))
end

X.Create = function(key)
    if not key then return false end
    if type(key) ~= 'string' then return false end
    key = trim(key)

    local loadFile = LoadResourceFile(GetCurrentResourceName(), './databases/' .. key .. '.json')
    if loadFile and loadFile ~= "" then
        print('jsaver: The data named ' .. key .. ' already exists. IGNORING...')
        return false
    end

    X.Data[key] = {}
    X.Changed[key] = false

    SaveResourceFile(GetCurrentResourceName(), './databases/' .. key .. '.json', json.encode(X.Data[key]), -1)

    return true
end

X.Load = function(key)
    if not key then return {} end
    if type(key) ~= 'string' then return {} end
    key = trim(key)

    local loadFile = LoadResourceFile(GetCurrentResourceName(), './databases/' .. key .. '.json')
    if loadFile and loadFile ~= "" then
        X.Data[key] = json.decode(loadFile)
        X.Changed[key] = false
        return X.Data[key]
    end
    print('jsaver: File don`t found: `' .. key .. '`. Try to create it first.')
    return {}
end

X.Save = function(key, data)
    if not key then return false end
    if type(key) ~= 'string' then return false end
    key = trim(key)

    if data and type(data) == 'table' then
        X.Set(key, data)
    end

    if not X.Data[key] then
        print('jsaver: Can`t save non exist data named: `' .. key .. '`.')
        return false
    end
    SaveResourceFile(GetCurrentResourceName(), './databases/' .. key .. '.json', json.encode(X.Data[key]), -1)
    
    if X.Changed[key] then
        X.Changed[key] = false
    end

    return true
end

X.Get = function(key)
    if not key then return {} end
    if type(key) ~= 'string' then return {} end
    key = trim(key)

    if X.Data[key] then
        return X.Data[key]
    end
    print('jsaver: Can`t find data with key `' .. key .. '`. How about load info first?')
    return {}
end

X.Set = function(key, data)
    if not key then return false end
    if type(key) ~= 'string' then return false end
    key = trim(key)

    if X.Data[key] then
        X.Data[key] = data
        X.Changed[key] = true
        return true
    end

    print('jsaver: Can`t find data with key `' .. key .. '`. How about load info first?')
    return false
end

X.Exists = function(key)
    if not key then return false end
    if type(key) ~= 'string' then return false end
    key = trim(key)

    if X.Data[key] then
        return true
    else
        local loadFile = LoadResourceFile(GetCurrentResourceName(), './databases/' .. key .. '.json')
        if loadFile and loadFile ~= "" then
            return true
        end
    end
    
    return false
end

X.Erase = function(key)
    if not key then return false end
    if type(key) ~= 'string' then return false end
    key = trim(key)

    if X.Changed[key] then X.Changed[key] = nil end
    if X.Data[key] then
        X.Data[key] = nil
        SaveResourceFile(GetCurrentResourceName(), './databases/' .. key .. '.json', '', -1)
        return true
    else
        local loadFile = LoadResourceFile(GetCurrentResourceName(), './databases/' .. key .. '.json')
        if loadFile and loadFile ~= "" then
            SaveResourceFile(GetCurrentResourceName(), './databases/' .. key .. '.json', '', -1)
            return true
        end
    end
    
    
    return false
end