---Modified version of util.sprite_load that takes a Spritter output table instead of Wube's format
---@param path string
---@param table table
---@return table
util.sprite_load_spritter = function(path, table)
  local original_shift = table.shift or {0, 0}
  local multiply_shift = table.multiply_shift or 1
  
  ---@type SpritterOutput
  local spritter = require(path)

  table.width  = spritter.width
  table.height = spritter.height

  local sprite_shift = spritter.shift or {0, 0}
  table.shift = {
    sprite_shift[1] * multiply_shift + original_shift[1],
    sprite_shift[2] * multiply_shift + original_shift[2]
  }

  table.line_length = spritter.line_length
  table.frames = spritter.sprite_count

  if table.frame_index then
    local column_index = table.frame_index % spritter.line_length
    local row_index = (table.frame_index - column_index) / spritter.line_length
    table.x = column_index * spritter.width
    table.y = row_index * spritter.height
    table.frame_index = nil
  end

  table.scale = spritter.scale or 1

  if spritter.file_count > 1 then
    local filenames = {}
    for i = 0, spritter.file_count - 1 do
      filenames[i + 1] = "-" .. i .. ".png"
    end

    local t = {}
    for k, v in pairs(filenames) do
      t[k] = path .. v
    end
    table.filenames = t
    table.lines_per_file = spritter.lines_per_file
    table.filename = nil
  else
    table.filename = path .. ".png"
    table.filenames = nil
  end

  return table
end