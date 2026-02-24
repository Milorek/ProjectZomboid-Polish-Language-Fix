-- Upewniamy się, że klasa istnieje, zanim spróbujemy ją nadpisać
if not ISWidgetRecipeCategories then
    -- Jeśli klasa nie jest jeszcze załadowana, musimy poczekać lub ją wymusić
    require "Xui/ISWidgetRecipeCategories" 
end

local original_populate = ISWidgetRecipeCategories.populateCategoryList

function ISWidgetRecipeCategories:populateCategoryList()
    self.recipeCategoryPanel:clear()
    
    -- Poprawione dodawanie stałych kategorii
    self.recipeCategoryPanel:addItem(getText("IGUI_CraftCategory_General"), "")
    self.recipeCategoryPanel:addItem(getText("IGUI_CraftCategory_Favorite"), "*")

    local currentCategoryFilterFound = self.selectedCategory == ""

    if self.selectedCategory == "*" then
        self.recipeCategoryPanel.selected = 2
        currentCategoryFilterFound = true
    end

    local categories = self.callbackTarget:getCategoryList()
    for i = 0, categories:size()-1 do
        local rawCategory = categories:get(i)
        
        -- TWOJA ZMIANA: Próba tłumaczenia nazwy przed wyświetleniem
        local translatedName = getTextOrNull("IGUI_CraftCategory_" .. rawCategory)
        
        -- Jeśli nie ma tłumaczenia, stosujemy oryginalną logikę z dużą literą
        local displayName = translatedName or (string.upper(string.sub(rawCategory, 1, 1)) .. string.sub(rawCategory, 2))
        
        local item = self.recipeCategoryPanel:addItem(displayName, rawCategory)

        if rawCategory == self.selectedCategory then
            self.recipeCategoryPanel.selected = item.itemindex
            currentCategoryFilterFound = true
        end
    end

    if not currentCategoryFilterFound then
        self:onCategoryChanged("")
    end

    if categories:size() > 0 then
        self.isInitialised = true
    end
end