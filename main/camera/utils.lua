local function get_viewport_size()
  local DISPLAY_WIDTH = sys.get_config_int("display.width")
  local DISPLAY_HEIGHT = sys.get_config_int("display.height")

  return {
    width = DISPLAY_WIDTH,
    height = DISPLAY_HEIGHT,
  }
end

local viewport_size = get_viewport_size()

local function get_window_size()
  local windows_width, windows_height = window.get_size()

  return {
    width = windows_width,
    height = windows_height,
  }
end

local function camera_to_world_coordinates(point, display, camera_url)
  local projection = go.get(camera_url, "projection")
  local view = go.get(camera_url, "view")
  local w, h = window.get_size()
  -- The window.get_size() function will return the scaled window size,
  -- ie taking into account display scaling (Retina screens on macOS for
  -- instance). We need to adjust for display scaling in our calculation.
  w = w / (w / display.width)
  h = h / (h / display.height)

  -- https://defold.com/manuals/camera/#converting-mouse-to-world-coordinates
  local inv = vmath.inv(projection * view)
  local x = (2 * point.x / w) - 1
  local y = (2 * point.y / h) - 1
  local z = (2 * point.z) - 1
  local x1 = x * inv.m00 + y * inv.m01 + z * inv.m02 + inv.m03
  local y1 = x * inv.m10 + y * inv.m11 + z * inv.m12 + inv.m13
  local z1 = x * inv.m20 + y * inv.m21 + z * inv.m22 + inv.m23
  return vmath.vector3(x1, y1, z1)
end

local function get_zoom_level()
  local display_size = get_viewport_size()
  local windows_width, windows_height = window.get_size()

  local zoom_level = 1
  zoom_level = math.min(windows_width / display_size.width, windows_height / display_size.height)

  return zoom_level
end

local function calculate_zoom_level(game_width, game_hight)
  local game_width = game_width or viewport_size.width
  local game_hight = game_hight or viewport_size.height

  local windows_width, windows_height = window.get_size()


  local game_aspect_ratio = game_width / game_hight
  local windows_aspect_ratio = windows_width / windows_height

  local zoom_by_height, zoom_by_width = windows_height / game_hight, windows_width / game_width

  if windows_aspect_ratio < game_aspect_ratio then
    print("zoom_by_width", zoom_by_width)
    return zoom_by_width
  end

  print("zoom_by_height", zoom_by_height)
  return zoom_by_height
end


return {
  calculate_zoom_level = calculate_zoom_level,
  camera_to_world_coordinates = camera_to_world_coordinates,
  get_window_size = get_window_size,
  viewport_size = viewport_size,
}
