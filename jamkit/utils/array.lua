local array = {}

array.merge = function(arrays,filter)
  local result = {}
  for _,array in ipairs(arrays) do
    for _,item in ipairs(array) do
      if filter then item = filter(item) end
      if item then table.insert(result,item) end
    end
  end
  return result
end

array.unorderedRemove = function(table,element)
  local isFunc = type(element) == "function"
  local i,s = 1,#table 
  while i <= s do 
    local item = table[i]
      if (isFunc and element(item)) or (item == element) then 
          table[i] = table[s] 
          table[s] = nil 
          s = s - 1
          break
      else 
        i = i + 1 
      end 
  end 
end

return array