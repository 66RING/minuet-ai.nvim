local M = {}
M.__index = M

function M.new(max)
    return setmetatable({
        max   = max,
        map   = {},
        queue = {},
        idx   = 0,
    }, M)
end

function M:set(key, value)
    self.idx = (self.idx + 1) % self.max
    -- erase next cache, which will be rewrite
    local oldKey = self.queue[self.idx]
    if oldKey ~= nil then
        self.map[oldKey] = nil
    end

    self.queue[self.idx] = key
    self.map[key] = value
end

function M:get(key, loader)
    return self.map[key]
end

local _instance
function M.get_instance()
    if not _instance then
        _instance = M.new(512)
    end
    return _instance
end

return M
