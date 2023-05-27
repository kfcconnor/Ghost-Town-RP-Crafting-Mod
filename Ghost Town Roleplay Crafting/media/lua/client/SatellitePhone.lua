-- helper lua file for doing timed actions...
require "TimedActions/ISBaseTimedAction"
require 'ISUI/ISPanel'
require 'ISUI/ISRichTextPanel'

-- declare a few variables to use.
defaultPadding = 6

local textManager = getTextManager();

local screenX = 65;
local screenY = 1;

local r = 0.1
local g = 0.8
local b = 1

-- function that is called once the timed action reaches complete. In this case, place the mine.
function checkCoords(pid)
	local player = getSpecificPlayer(pid)
	if player then
		local playerX = player:getX();
		local playerY = player:getY();
		local txt = "Location:  " .. round(playerX) .. " x " .. round(playerY)
		
		player:Say(txt);
		
		-- textManager:DrawString(UIFont.Large, screenX, screenY + 7, txt, r, g, b, 1);
	end
end

local function round(_num)
	local number = _num;
	return number <= 0 and floor(number) or floor(number + 0.5);
end


Coords = {};

Coords.doMenu = function(player, context, items)
    local coords = nil;
    
    for i,v in ipairs(items) do
        local tempitem = v;
        if not instanceof(v, "InventoryItem") then
            tempitem = v.items[1];
        end
        if tempitem:getDisplayName() == "Satellite Phone" then
            coords = tempitem;
        end
    end
    if coords ~= nil then
        context:addOption(getText("Get Location"), player, checkCoordsNow , items);
    end
end

function checkCoordsNow(player)
	
	checkCoords(player);

end

Events.OnFillInventoryObjectContextMenu.Add(Coords.doMenu);
