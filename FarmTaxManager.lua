--========================================================--
-- FS25 Farm Tax Manager | by Jessie Crider (CriderGPT)
-- Version: 1.1.0.0 | Console Safe | Virginia Tax Simulation
--========================================================--

FarmTaxManager = {}
local FarmTaxManager_mt = Class(FarmTaxManager)

--- Constructor
function FarmTaxManager:new(mission, i18n)
    local self = setmetatable({}, FarmTaxManager_mt)
    self.mission = mission
    self.i18n = i18n
    self.taxIntervalDays = 30          -- property tax every 30 in-game days
    self.landTaxRate = 12.5            -- $ per hectare
    self.vehicleTaxRate = 25.0         -- $ per vehicle
    self.salesTaxRate = 0.052          -- 5.2% sales tax
    self.lastTaxDay = 0
    return self
end

--========================================================--
-- REGISTER & INITIALIZATION
--========================================================--
function FarmTaxManager:loadMap(name)
    self.mission:addUpdateable(self)
    g_messageCenter:subscribe(MessageType.DAY_CHANGED, self.onDayChanged, self)
    g_messageCenter:subscribe(MessageType.MONEY_CHANGED, self.onMoneyChanged, self)
    Logging.info("FS25 Farm Tax Manager loaded | v1.1 Console Safe Edition")
end

--========================================================--
-- DAY CHANGE HANDLER
--========================================================--
function FarmTaxManager:onDayChanged(day)
    if (day - self.lastTaxDay) >= self.taxIntervalDays then
        self:calculatePropertyTax()
        self.lastTaxDay = day
    end
end

--========================================================--
-- PROPERTY TAX CALCULATION
--========================================================--
function FarmTaxManager:calculatePropertyTax()
    local farmId = self.mission:getFarmId()
    local farm = g_farmManager:getFarmById(farmId)
    if farm == nil then return end

    local totalArea = 0
    for _, farmland in pairs(g_farmlandManager.farmlands) do
        if farmland.ownerFarmId == farmId then
            totalArea = totalArea + farmland.area
        end
    end

    local vehicleCount = 0
    for _, vehicle in pairs(self.mission.vehicles) do
        if vehicle:getOwnerFarmId() == farmId then
            vehicleCount = vehicleCount + 1
        end
    end

    local totalTax = (totalArea * self.landTaxRate) + (vehicleCount * self.vehicleTaxRate)
    if farm:getBalance() >= totalTax then
        farm:addMoney(-totalTax, "Property Tax", MoneyType.OTHER)
        self:showHUD(string.format("💵 Property Tax Paid: $%.2f", totalTax))
    else
        self:showHUD("⚠️ Insufficient funds for property tax!")
    end
end

--========================================================--
-- SALES TAX HANDLER
--========================================================--
function FarmTaxManager:onMoneyChanged(farmId, amount, moneyType, farmName, reason)
    if amount > 0 and (moneyType == MoneyType.HARVEST_INCOME or moneyType == MoneyType.PRODUCT_SALE) then
        local tax = amount * self.salesTaxRate
        local farm = g_farmManager:getFarmById(farmId)
        if farm ~= nil then
            farm:addMoney(-tax, "Sales Tax", MoneyType.OTHER)
            self:showHUD(string.format("🧾 Sales Tax (%.1f%%): -$%.2f", self.salesTaxRate * 100, tax))
        end
    end
end

--========================================================--
-- HUD MESSAGE (Console Safe)
--========================================================--
function FarmTaxManager:showHUD(text)
    if g_currentMission ~= nil and g_currentMission.hud ~= nil then
        g_currentMission.hud:addSideNotification(text)
    else
        print(text)
    end
end

addModEventListener(FarmTaxManager:new(g_currentMission, g_i18n))
