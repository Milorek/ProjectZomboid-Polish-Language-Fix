require "Xui/Visual/ISWidgetHandCraftControl"

local BUTTON_SIZE = 40
local BUTTON_ICON_SIZE = 32

function ISWidgetHandCraftControl:createChildren()
    ISPanelJoypad.createChildren(self);

    self.colProgress = safeColorToTable(self.xuiSkin:color("C_ValidGreen"));

    local fontHeight = -1; -- <=0 sets label initial height to font
    
    self.quantityLabel = ISXuiSkin.build(self.xuiSkin, "S_NeedsAStyle", ISLabel, 0, 0, fontHeight, getText("IGUI_CraftingWindow_Quantity"), 1, 1, 1, 1, UIFont.Small, true);
    self.quantityLabel:initialise();
    self.quantityLabel:instantiate();
    self:addChild(self.quantityLabel);
    
    self.durationLabel = ISXuiSkin.build(self.xuiSkin, "S_NeedsAStyle", ISLabel, 0, 0, fontHeight, getText("IGUI_CraftingWindow_TimeRequired"), 1, 1, 1, 1, UIFont.Small, true);
    self.durationLabel:initialise();
    self.durationLabel:instantiate();
    self:addChild(self.durationLabel);

    self.entryBox = ISXuiSkin.build(self.xuiSkin, "S_NeedsAStyle", ISTextEntryBox, "", 0, 0, 70, 20);
    self.entryBox.font = UIFont.Small;
    self.entryBox:initialise();
    self.entryBox:instantiate();
    self.entryBox.onLostFocus = ISWidgetHandCraftControl.onTextChange;
    self.entryBox.target = self;
    self.entryBox:setClearButton(true);
    self.entryBox:setOnlyNumbers(true);
    self:addChild(self.entryBox);

    local buttonSize = getTextManager():getFontHeight(UIFont.Small) + 2;
    
    self.buttonMax = ISXuiSkin.build(self.xuiSkin, "S_NeedsAStyle", ISButton, 0, 0, buttonSize*2, buttonSize, "MAX")
    --self.buttonPrev.image = getTexture("ArrowLeft");
    self.buttonMax.font = UIFont.Small;
    self.buttonMax.target = self;
    self.buttonMax.onclick = ISWidgetHandCraftControl.onButtonClick;
    self.buttonMax.enable = true;
    self.buttonMax:initialise();
    self.buttonMax:instantiate();
    --self.buttonMax.originalTitle = self.buttonMax.title;
    self:addChild(self.buttonMax);

    self.buttonMore = ISXuiSkin.build(self.xuiSkin, "S_NeedsAStyle", ISButton, 0, 0, buttonSize, buttonSize, "")
    self.buttonMore.image = getTexture("media/ui/Entity/BTN_Plus_Icon_48x48.png");
    self.buttonMore.target = self;
    self.buttonMore.onclick = ISWidgetHandCraftControl.onButtonClick;
    self.buttonMore.enable = true;
    self.buttonMore:initialise();
    self.buttonMore:instantiate();
    self:addChild(self.buttonMore);

    self.buttonLess = ISXuiSkin.build(self.xuiSkin, "S_NeedsAStyle", ISButton, 0, 0, buttonSize, buttonSize, "")
    self.buttonLess.image = getTexture("media/ui/Entity/BTN_Minus_Icon_48x48.png");
    self.buttonLess.target = self;
    self.buttonLess.onclick = ISWidgetHandCraftControl.onButtonClick;
    self.buttonLess.enable = true;
    self.buttonLess:initialise();
    self.buttonLess:instantiate();
    self:addChild(self.buttonLess);

    local style = self.styleBar or "S_ProgressBar_Craft";
    self.progressBar = ISXuiSkin.build(self.xuiSkin, style, ISProgressBar, 0, 0, 150, buttonSize, false, UIFont.Small);
    self.progressBar.progressColor = self.colProgress;
    --self.progressBar.progressTexture = self.horzTexture;
    self.progressBar:initialise();
    self.progressBar:instantiate();
    self.progressBar:setProgress(0);
    self:addChild(self.progressBar);

    --self.originalBarWidth = self.progressBar:getWidth();
    --self.originalBarHeight = self.progressBar:getHeight();

    --self.slider = ISXuiSkin.build(self.xuiSkin, "S_NeedsAStyle", ISSliderPanel,0, 0, 100, 18, self, ISWidgetHandCraftControl.onSliderChange );
    --self.slider.minValue = 1;
    --self.slider:initialise();
    --self.slider:instantiate();
    --self.slider.valueLabel = false;
    --self.slider.maxValue = self.logic:getPossibleCraftCount(false);
    --self.slider:setCurrentValue( 1, true );
    ----self.slider.customData = _data;
    --self:addChild(self.slider);

    self.buttonCraft = ISXuiSkin.build(self.xuiSkin, "S_NeedsAStyle", ISButton, 0, 0, BUTTON_SIZE * 1.5, BUTTON_SIZE, getText("IGUI_CraftingWindow_Craft"))
    --self.buttonPrev.image = getTexture("ArrowLeft");
    self.buttonCraft.font = UIFont.Small;
    self.buttonCraft.target = self;
    self.buttonCraft.onclick = ISWidgetHandCraftControl.onButtonClick;
    self.buttonCraft.enable = true;
    self.buttonCraft:initialise();
    self.buttonCraft:instantiate();
    --self.buttonCraft.originalTitle = self.buttonCraft.title;
    self:addChild(self.buttonCraft);

    self.origButtonHeight = self.buttonCraft:getHeight();

    -- Debug tool to force being able to do recipes regardless of knowing recipes, skills, whatever
    if isDebugEnabled() and debugSpam then
        self.buttonForceCraft = ISXuiSkin.build(self.xuiSkin, "S_NeedsAStyle", ISButton, 0, 0, BUTTON_SIZE * 1.5, BUTTON_SIZE, "Force Action")
        self.buttonForceCraft.iconTexture = getTexture("media/textures/Item_Plumpabug_Left.png");
        self.buttonForceCraft.joypadTextureWH = BUTTON_ICON_SIZE;
        --self.buttonPrev.image = getTexture("ArrowLeft");
        self.buttonForceCraft.font = UIFont.Small;
        self.buttonForceCraft.target = self;
        self.buttonForceCraft.onclick = ISWidgetHandCraftControl.onButtonClick;
        self.buttonForceCraft.enable = true;
        self.buttonForceCraft:initialise();
        self.buttonForceCraft:instantiate();
        self.buttonForceCraft.originalTitle = self.buttonForceCraft.title;
        self:addChild(self.buttonForceCraft);
    end
    -- debug tool to know all recipes
--     if isDebugEnabled() and debugSpam then
--         self.buttonKnowAllRecipes = ISXuiSkin.build(self.xuiSkin, "S_NeedsAStyle", ISButton, 0, 0, BUTTON_SIZE * 1.5, BUTTON_SIZE, "(DEBUG) TOGGLE KNOW ALL RECIPES")
--         self.buttonKnowAllRecipes.iconTexture = getTexture("media/textures/Item_Plumpabug_Left.png");
--         --self.buttonPrev.image = getTexture("ArrowLeft");
--         self.buttonKnowAllRecipes.font = UIFont.Small;
--         self.buttonKnowAllRecipes.target = self;
--         self.buttonKnowAllRecipes.onclick = ISWidgetHandCraftControl.onButtonClick;
--         self.buttonKnowAllRecipes.enable = true;
--         self.buttonKnowAllRecipes:initialise();
--         self.buttonKnowAllRecipes:instantiate();
--         self.buttonKnowAllRecipes.originalTitle = self.buttonKnowAllRecipes.title;
--         self:addChild(self.buttonKnowAllRecipes);
--     end

    self.boxHeight = self.height;
    
    self:setCraftQuantity(1);
end

function ISWidgetHandCraftControl:prerender()
    --ISPanelJoypad.prerender(self);

	if self.background then
		self:drawRectStatic(0, 0, self.width, self.boxHeight, self.backgroundColor.a, self.backgroundColor.r, self.backgroundColor.g, self.backgroundColor.b);
		self:drawRectBorderStatic(0, 0, self.width, self.boxHeight, self.borderColor.a, self.borderColor.r, self.borderColor.g, self.borderColor.b);
	end

    --local y = self.autoToggle:getY() + self.autoToggle:getHeight() + self.margin;
    --self:drawRectStatic(0, y, self.width, 1, self.borderColor.a, self.borderColor.r, self.borderColor.g, self.borderColor.b);

    if self.durationLabel then
        if self.logic and self.logic:getRecipe() then
            local seconds = self.logic:getRecipe():getTime(self.player);
--             local seconds = self.logic:getRecipe():getTime();
            -- changed because weird artifacts were happening for sub 1 minute recipes
            local mm
            if seconds < 60 then mm = 0
            else mm = round(seconds / 60, 0) end;

--             local mm = round(seconds / 60, 0);
            local ss = math.fmod(seconds, 60);
            local text = getText("IGUI_CraftingWindow_TimeRequired")..string.format("%02dm %02ds", mm, ss);
            self.durationLabel:setName(text)
        else
            self.durationLabel:setName(getText("IGUI_CraftingWindow_TimeRequired").."??")
        end
    end
    
    if self.logic and self.logic:isCraftActionInProgress() and self.logic:getCraftActionTable() then
        local action = self.logic:getCraftActionTable();
        local plrQueue = ISTimedActionQueue.getTimedActionQueue(self.player);
        if plrQueue and plrQueue.queue and plrQueue.queue[1] and plrQueue.queue[1]==action then
            if self.progressBar then
                self.progressBar:setProgress(action:getJobDelta());
                local title = tostring(round(action:getJobDelta()*100, 0)).."%"
                self.progressBar:setText(title);
            end
            if self.buttonCraft then
                --self.buttonCraft:setVisible(false);
                self.buttonCraft.enable = false;
                ----self.buttonCraft.displayBackground = false;
                ----self.buttonCraft:drawProgressBar(0, 0, self.buttonCraft:getWidth(), self.buttonCraft:getHeight(), action:getJobDelta(), self.colProgress);
                ----self.buttonCraft.title = tostring(round(action:getJobDelta()*100, 0)).."%";
--
                --local title = tostring(round(action:getJobDelta()*100, 0)).."%";
                --local x = self.buttonCraft:getX();
                --local y = self.buttonCraft:getY();
                --local width = self.buttonCraft:getWidth();
                --local height = self.buttonCraft:getHeight();
--
                --self:drawProgressBar(x, y, width, height, action:getJobDelta(), self.colProgress);
--
                --local c = 0.3;
                --self:drawRectBorder(x, y, width, height, 1.0, c, c, c);
--
                --local textW = getTextManager():MeasureStringX(self.buttonCraft.font, title)
                --local textH = getTextManager():MeasureStringY(self.buttonCraft.font, title)
                ----log(DebugType.CraftLogic, "TextH = "..tostring(textH)..", TextW = "..tostring(textW))
                --x = x + ((width / 2) - (textW / 2));
                --y = y + ((height / 2) - (textH/2) + self.buttonCraft.yoffset);
                --c = 0.1;
                --self:drawText(title, x+1, y+1, c, c, c, 1, self.buttonCraft.font);
                --self:drawText(title, x+1, y-1, c, c, c, 1, self.buttonCraft.font);
                --self:drawText(title, x-1, y-1, c, c, c, 1, self.buttonCraft.font);
                --self:drawText(title, x-1, y+1, c, c, c, 1, self.buttonCraft.font);
                --c = 0.95;
                --self:drawText(title, x, y, c, c, c, 1, self.buttonCraft.font);
            end
        end
    else
        if self.buttonCraft then
            self.buttonCraft.enable = self.logic:cachedCanPerformCurrentRecipe();
            --self.buttonCraft:setVisible(true);
            --self.buttonCraft.displayBackground = true;
            --self.buttonCraft.title = self.buttonCraft.originalTitle;
        end
        if self.progressBar then
            self.progressBar:setProgress(0);
            self.progressBar:setText("");
        end
    end
end