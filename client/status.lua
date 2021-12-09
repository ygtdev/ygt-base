status = false
type = false
time = 0
lasttime = 0

Citizen.CreateThread(function()
	while true do
        if status then
            if time < lasttime then
			    TriggerEvent('ygt_status:add', type, 10000)
                time = time + 1
            else
                status = false
                type = false
                time = 0
                lasttime = 0
            end
        end
        Citizen.Wait(1000)
	end
end)