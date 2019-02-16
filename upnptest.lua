local uPnPclient = assert(require('uPnPclientZ'))
local inspect = assert(require'inspect')

-- Get client object

local uc = uPnPclient:new{ debug_level = 1 }

-- Find the InternetGatewayDevice
local ret, err = uc:discoverIGD()

if not ret then
    print("FAILED: " .. err)
    -- return 1
end

--print('found igd:',inspect(ret))
function addMap()
    -- Port forward internetIP:80 -> thisHostIP:8080
    local ok, err = uc:AddPortMapping('tcp', 8009, 8009, "HTTP:8009 to this host on port 8009 for an hour", 3600)

    if ok then
        print("Add mapping SUCCESS!")
    elseif err then
        print("Add FAILURE: " .. err .. "\n")
    end
end
function delMap()
    -- Delete port forward internetIP:80 -> thisHostIP:8080
    local ok, err = uc:DeletePortMapping('tcp', 8009, 8009, "HTTP:8009 to this host on port 8009 for an hour", 3600)

    if ok then
        print("Delete SUCCESS!")
    elseif err then
        print("Delete FAILURE: " .. err .. "\n")
    end
end

--local cm=uc:GetListOfPortMappings()
--print('current pm:',inspect(cm))
print('current external ip:',uc:GetExternalIPAddress())
--addMap()
delMap()
