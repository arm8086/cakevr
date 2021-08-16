local RunService = game:GetService("RunService")
local char = owner.Character
char.Humanoid.WalkSpeed = 0
char.Humanoid.JumpPower = 0
local spawn = function(f) coroutine.resume(coroutine.create(f)) end
owner.CameraMode = Enum.CameraMode.LockFirstPerson
local screenvp = Instance.new("ScreenGui")
screenvp.Name = "screenvp"
screenvp.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenvp.IgnoreGuiInset = true
local e = Instance.new("Frame")
e.Name = "e"
e.Size = UDim2.new(1, 0, 1, 0)
e.BackgroundColor3 = Color3.fromRGB(58, 58, 58)
e.Parent = screenvp
local vpf = Instance.new("ViewportFrame")
vpf.Name = "vpf"
vpf.ClipsDescendants = true
vpf.Size = UDim2.new(0.3982169, 0, 1, 0)
vpf.Position = UDim2.new(0.3008915, 0, 0, 0)
vpf.BorderSizePixel = 0
vpf.BackgroundColor3 = Color3.fromRGB(88, 82, 81)
vpf.Parent = e
local Camera = Instance.new("Camera")
Camera.CFrame = CFrame.new(0, 3.5, 0, -1, 0, 2.7814184022645e-07, 0, 1, 0, -2.7814184022645e-07, 0, -1)
Camera.CoordinateFrame = CFrame.new(0, 3.5, 0, -1, 0, 2.7814184022645e-07, 0, 1, 0, -2.7814184022645e-07, 0, -1)
Camera.Parent = vpf
local model = Instance.new("WorldModel")
model.Parent = vpf

local playarea = Instance.new("Part")
playarea.Name = "playarea"
playarea.BottomSurface = Enum.SurfaceType.Smooth
playarea.TopSurface = Enum.SurfaceType.Smooth
playarea.Color = Color3.fromRGB(27, 42, 53)
playarea.Size = Vector3.new(16, 1, 16)
playarea.Parent = model
vpf.CurrentCamera = Camera
local gridtexture = Instance.new("Texture")
gridtexture.Name = "gridtexture"
gridtexture.Face = Enum.NormalId.Top
gridtexture.Texture = "rbxassetid://429772319"
gridtexture.StudsPerTileV = 8
gridtexture.StudsPerTileU = 8
gridtexture.Parent = playarea
screenvp.Parent = owner.PlayerGui

--// new stuff will be here
local winfol = Instance.new("Folder",vpf)

local library = Instance.new("Frame")
library.Name = "library"
library.Size = UDim2.new(0, 300, 0, 100)
library.BackgroundTransparency = 0.6
library.Position = UDim2.new(0,117,0,278)
library.BorderSizePixel = 0
library.BackgroundColor3 = Color3.fromRGB(124, 124, 124)
local text1 = Instance.new("TextBox")
text1.Name = "text1"
text1.Size = UDim2.new(0, 72, 0, 24)
text1.BackgroundTransparency = 1
text1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
text1.FontSize = Enum.FontSize.Size24
text1.TextSize = 24
text1.TextColor3 = Color3.fromRGB(255, 255, 255)
text1.Text = "Library"
text1.ClearTextOnFocus = false
text1.TextEditable = false
text1.Font = Enum.Font.SourceSansLight
text1.Parent = library
local item1 = Instance.new("ImageLabel")
item1.Name = "item1"
item1.Size = UDim2.new(0, 80, 0, 50)
item1.BackgroundTransparency = 0.3
item1.Position = UDim2.new(0, 0, 0, 30)
item1.BorderSizePixel = 0
item1.BackgroundColor3 = Color3.fromRGB(71, 71, 71)
item1.ScaleType = Enum.ScaleType.Fit
item1.Image = "rbxassetid://7243734663"
item1.Parent = library
local TextLabel = Instance.new("TextLabel")
TextLabel.Size = UDim2.new(0, 160, 0, 50)
TextLabel.ClipsDescendants = true
TextLabel.BackgroundTransparency = 1
TextLabel.Position = UDim2.new(0, 100, 0, 0)
TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.FontSize = Enum.FontSize.Size18
TextLabel.TextSize = 18
TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.Text = "Virtual Virtual Desktop"
TextLabel.TextYAlignment = Enum.TextYAlignment.Top
TextLabel.TextWrap = true
TextLabel.Font = Enum.Font.SourceSansSemibold
TextLabel.TextWrapped = true
TextLabel.TextXAlignment = Enum.TextXAlignment.Left
TextLabel.TextScaled = true
TextLabel.Parent = item1
local UIListLayout = Instance.new("UIListLayout")
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 5)
UIListLayout.Parent = library
library.Parent = winfol

--//

function gc(i,v)
	game:service'Debris':AddItem(i,v or 0)
end

--// cleanup
for i,v in pairs(game:GetService("ReplicatedStorage"):GetChildren()) do
	if v.Name == "VR_Remotes" then
		gc(v)
	end
end
--// cleanup

local cm = true

local remotes = Instance.new("Folder")
remotes.Name = "VR_Remotes"
remotes.Parent = game:GetService("ReplicatedStorage")

local vr_0 = Instance.new("BindableEvent")
vr_0.Name = "0"
vr_0.Parent = remotes

vr_keybinds = Instance.new("BindableEvent")
vr_keybinds.Name = "1"
vr_keybinds.Parent = remotes

local delta

local direction

local client = NLS([[
	local controller = game:GetService("ReplicatedStorage"):WaitForChild("VR_Remotes"):WaitForChild("0")
	local input = game:GetService("ReplicatedStorage"):WaitForChild("VR_Remotes"):WaitForChild("1")
	local camera = workspace.CurrentCamera
	local uis = game:GetService("UserInputService")
	
	function keyDown(key)
		return not uis:GetFocusedTextBox() and uis:IsKeyDown(Enum.KeyCode[key]) or false
	end
	
	uis.InputBegan:Connect(function(io,rh)
		if rh then return end
		if io.KeyCode == Enum.KeyCode.Y then
			input:Fire("SwitchCameraMode")
		elseif io.KeyCode == Enum.KeyCode.X then
			input:Fire("Teleport",{true})
		end
	end)
	uis.InputEnded:Connect(function(io,rh)
		if rh then return end
		if io.KeyCode == Enum.KeyCode.X then
			input:Fire("Teleport",{false})
		end
	end)
	spawn(function() 
		while wait(0.05) do
			if keyDown("Q") then
				input:Fire("RollLeft")
			elseif keyDown("E") then
				input:Fire("RollRight")
			end
		end
	end)
	
	while wait() do
		controller:Fire(uis:GetMouseDelta())
	end
]],owner.PlayerGui)

local rM = true

spawn(function()
	while wait() do
		spawn(function()
			for i,v in pairs(winfol:GetChildren()) do
				v.Position = v.Position+UDim2.new(0,-delta.X*13,0,-delta.Y*13)
			end
		end)
		if cm then
			owner.CameraMode = Enum.CameraMode.LockFirstPerson
		else
			owner.CameraMode = Enum.CameraMode.Classic
		end
	end
end)

local ControllerBind = vr_0.Event:Connect(function(hit)
	delta = hit
	Camera.CFrame = Camera.CFrame * CFrame.Angles(math.rad(-hit.Y),math.rad(-hit.X),0)
end)

function rayCast(Position,Direction,Range,Ignore)
	return workspace:FindPartOnRay(Ray.new(Position,Direction.unit * (Range or 999.999)),Ignore) 
end 

local InputBind = vr_keybinds.Event:Connect(function(type,val)
	if type == "SwitchCameraMode" then
		cm = not cm
	elseif type == "RollLeft" then
		Camera.CFrame = Camera.CFrame * CFrame.Angles(0,0,0.1)
	elseif type == "RollRight" then
		Camera.CFrame = Camera.CFrame * CFrame.Angles(0,0,-0.1)
	elseif type == "Teleport" then
		if val[1] == true then
			
		else
			Camera.CFrame = Camera.CFrame * CFrame.new(3.5,0,0)
		end
	elseif type == "ChangeRotationMode" then
		rM = not rM
	end
end)
local ChatBind = owner.Chatted:Connect(function(msg) --added this because nogui doesnt work on gui created on the client
	if msg == "g/no. sr" then
		owner.CameraMode = Enum.CameraMode.Classic
		char.Humanoid.WalkSpeed = 16
		char.Humanoid.JumpPower = 50
		gc(screenvp)
		gc(client)
		gc(remotes)
	end
end)
