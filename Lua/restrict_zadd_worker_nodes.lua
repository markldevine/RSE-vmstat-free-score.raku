
-- restrict_zadd_worker_nodes.lua
-- Purpose: Restrict ZADD operations on the sorted set "RSE^worker-node-candidates"
-- so that only allowed worker nodes (mos01, mos02, mos03) can add entries.

-- Allowed worker nodes
local allowed_nodes = {
    mos01 = true,
    mos02 = true,
    mos03 = true
}

-- Arguments:
-- KEYS[1] = Sorted set key (should be "RSE^worker-node-candidates")
-- ARGV[1] = Worker node ID
-- ARGV[2] = Score
-- ARGV[3] = Member

local key = KEYS[1]
local node_id = ARGV[1]
local score = ARGV[2]
local member = ARGV[3]

-- Validate key name
if key ~= "RSE^worker-node-candidates" then
    return redis.error_reply("Invalid key: " .. key)
end

-- Validate node ID
if not allowed_nodes[node_id] then
    return redis.error_reply("Node '" .. node_id .. "' is not authorized to add entries.")
end

-- Perform ZADD
