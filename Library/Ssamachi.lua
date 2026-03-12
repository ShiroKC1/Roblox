local Release = "Release"
local NotificationDuration = 5.0
local SsamachiFolder = "Ssamachi"
local ConfigurationFolder = SsamachiFolder .. "/Configurations"
local ConfigurationExtension = ".rfld"
local SsamachiQuality = {}

local SsamachiLibrary = {
	Flags = {},
	Theme = {
		Default = {
			TextFont = "Default",
			TextColor = Color3.fromRGB(240, 240, 240),

			Background = Color3.fromRGB(25, 25, 25),
			Topbar = Color3.fromRGB(34, 34, 34),
			Shadow = Color3.fromRGB(20, 20, 20),

			NotificationBackground = Color3.fromRGB(20, 20, 20),
			NotificationActionsBackground = Color3.fromRGB(230, 230, 230),

			TabBackground = Color3.fromRGB(80, 80, 80),
			TabStroke = Color3.fromRGB(85, 85, 85),
			TabBackgroundSelected = Color3.fromRGB(210, 210, 210),
			TabTextColor = Color3.fromRGB(240, 240, 240),
			SelectedTabTextColor = Color3.fromRGB(50, 50, 50),

			ElementBackground = Color3.fromRGB(35, 35, 35),
			ElementBackgroundHover = Color3.fromRGB(40, 40, 40),
			SecondaryElementBackground = Color3.fromRGB(25, 25, 25),
			ElementStroke = Color3.fromRGB(50, 50, 50),
			SecondaryElementStroke = Color3.fromRGB(40, 40, 40),

			SliderBackground = Color3.fromRGB(43, 105, 159),
			SliderProgress = Color3.fromRGB(43, 105, 159),
			SliderStroke = Color3.fromRGB(48, 119, 177),

			ToggleBackground = Color3.fromRGB(30, 30, 30),
			ToggleEnabled = Color3.fromRGB(0, 146, 214),
			ToggleDisabled = Color3.fromRGB(100, 100, 100),
			ToggleEnabledStroke = Color3.fromRGB(0, 170, 255),
			ToggleDisabledStroke = Color3.fromRGB(125, 125, 125),
			ToggleEnabledOuterStroke = Color3.fromRGB(100, 100, 100),
			ToggleDisabledOuterStroke = Color3.fromRGB(65, 65, 65),

			InputBackground = Color3.fromRGB(30, 30, 30),
			InputStroke = Color3.fromRGB(65, 65, 65),
			PlaceholderColor = Color3.fromRGB(178, 178, 178)
		},
		Light = {
			TextFont = "Gotham",
			TextColor = Color3.fromRGB(50, 50, 50),

			Background = Color3.fromRGB(255, 255, 255),
			Topbar = Color3.fromRGB(217, 217, 217),
			Shadow = Color3.fromRGB(223, 223, 223),

			NotificationBackground = Color3.fromRGB(20, 20, 20),
			NotificationActionsBackground = Color3.fromRGB(230, 230, 230),

			TabBackground = Color3.fromRGB(220, 220, 220),
			TabStroke = Color3.fromRGB(112, 112, 112),
			TabBackgroundSelected = Color3.fromRGB(0, 142, 208),
			TabTextColor = Color3.fromRGB(240, 240, 240),
			SelectedTabTextColor = Color3.fromRGB(50, 50, 50),

			ElementBackground = Color3.fromRGB(198, 198, 198),
			ElementBackgroundHover = Color3.fromRGB(230, 230, 230),
			SecondaryElementBackground = Color3.fromRGB(136, 136, 136),
			ElementStroke = Color3.fromRGB(180, 199, 97),
			SecondaryElementStroke = Color3.fromRGB(40, 40, 40),

			SliderBackground = Color3.fromRGB(31, 159, 71),
			SliderProgress = Color3.fromRGB(31, 159, 71),
			SliderStroke = Color3.fromRGB(42, 216, 94),

			ToggleBackground = Color3.fromRGB(170, 203, 60),
			ToggleEnabled = Color3.fromRGB(32, 214, 29),
			ToggleDisabled = Color3.fromRGB(100, 22, 23),
			ToggleEnabledStroke = Color3.fromRGB(17, 255, 0),
			ToggleDisabledStroke = Color3.fromRGB(65, 8, 8),
			ToggleEnabledOuterStroke = Color3.fromRGB(0, 170, 0),
			ToggleDisabledOuterStroke = Color3.fromRGB(170, 0, 0),

			InputBackground = Color3.fromRGB(31, 159, 71),
			InputStroke = Color3.fromRGB(19, 65, 31),
			PlaceholderColor = Color3.fromRGB(178, 178, 178)
		},
	}
}

local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local LocalPlayer = game:GetService('Players').LocalPlayer

local Ssamachi = game:GetObjects("rbxassetid://13853811008")[1]
Ssamachi.Enabled = false

local Spawn = task.spawn
local Delay = task.delay

if game["Run Service"]:IsStudio() then
	function gethui()
		return Ssamachi
	end
	
	local HttpRequest = nil
	local Syn = {protect_gui = false, request = false}
	local Http = nil 
	
	function writefile(Tt, T, Ttt) end
	function isfolder(T) end
	function makefolder(T) end
	function isfile(R) end
	function readfile(T) end
end

pcall(function()
	_G.LastSsamachi.Name = 'Old Ssamachi'
	_G.LastSsamachi.Enabled = false
end)

local ParentObject = function(Gui)
	local Success, Failure = pcall(function()
		if get_hidden_gui or gethui then
			local HiddenUI = get_hidden_gui or gethui
			Gui.Parent = HiddenUI()
		elseif (not is_sirhurt_closure) and (Syn and Syn.protect_gui) then
			Syn.protect_gui(Gui)
			Gui.Parent = CoreGui
		elseif CoreGui then
			Gui.Parent = CoreGui
		end
	end)

	if not Success and Failure then
		Gui.Parent = LocalPlayer:FindFirstChildWhichIsA("PlayerGui")
	end

	_G.LastSsamachi = Ssamachi
end

ParentObject(Ssamachi)

local Camera = workspace.CurrentCamera
local Main = Ssamachi.Main
local Topbar = Main.Topbar
local Elements = Main.Elements
local LoadingFrame = Main.LoadingFrame
local TopList = Main.TabList
local SideList = Main.SideTabList.Holder
local TabsList = TopList and SideList
local SearchBar = Main.Searchbar
local Filler = SearchBar.CanvasGroup.Filler
local Prompt = Main.Prompt
local NotePrompt = Main.NotePrompt
local InfoPrompt = Ssamachi.Info

Ssamachi.DisplayOrder = 100
Elements.UIPageLayout.TouchInputEnabled = false
LoadingFrame.Version.Text = Release

local Request = Request or (Syn and Syn.request) or (Http and Http.request) or HttpRequest
local CFileName = nil
local CEnabled = false
local Minimised = false
local Hidden = false
local Debounce = false
local Clicked = false
local SearchHided = true
local SideBarClosed = true
local InfoPromptOpen = false
local BarType = 'Side'
local HoverTime = 0.3
local Notifications = Ssamachi.Notifications

local SelectedTheme = SsamachiLibrary.Theme.Default

function ChangeTheme(ThemeName)
	SelectedTheme = Ssamachi.Theme[ThemeName]

	for _, Obj in ipairs(Ssamachi:GetDescendants()) do
		if Obj.ClassName == "TextLabel" or Obj.ClassName == "TextBox" or Obj.ClassName == "TextButton" then
			if SelectedTheme.TextFont ~= "Default" then 
				Obj.TextColor3 = SelectedTheme.TextColor
				Obj.Font = SelectedTheme.TextFont
			end
		end
	end

	Ssamachi.Main.BackgroundColor3 = SelectedTheme.Background
	Ssamachi.Main.Topbar.BackgroundColor3 = SelectedTheme.Topbar
	Ssamachi.Main.Topbar.CornerRepair.BackgroundColor3 = SelectedTheme.Topbar
	Ssamachi.Main.Shadow.Image.ImageColor3 = SelectedTheme.Shadow

	Ssamachi.Main.Topbar.ChangeSize.ImageColor3 = SelectedTheme.TextColor
	Ssamachi.Main.Topbar.Hide.ImageColor3 = SelectedTheme.TextColor
	Ssamachi.Main.Topbar.Theme.ImageColor3 = SelectedTheme.TextColor

	for _, TabPage in ipairs(Elements:GetChildren()) do
		for _, Element in ipairs(TabPage:GetChildren()) do
			if Element.ClassName == "Frame" and Element.Name ~= "Placeholder" and Element.Name ~= "SectionSpacing" and Element.Name ~= "" then
				Element.BackgroundColor3 = SelectedTheme.ElementBackground
				Element.UIStroke.Color = SelectedTheme.ElementStroke
			end
		end
	end
end

local function AddDraggingFunctionality(DragPoint, Main)
	pcall(function()
		local Dragging, DragInput, MousePos, FramePos, Conduct = false, false, false, false, false

		UserInputService.InputBegan:Connect(function(Input)
			if (Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch) then
				Conduct = true

				Input.Changed:Connect(function()
					if Input.UserInputState == Enum.UserInputState.End then
						Conduct = false
					end
				end)
			end
		end)

		DragPoint.InputBegan:Connect(function(Input)
			if (Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch) and not Conduct then
				Dragging = true
				MousePos = Input.Position
				FramePos = Main.Position

				Input.Changed:Connect(function()
					if Input.UserInputState == Enum.UserInputState.End then
						Dragging = false
					end
				end)
			end
		end)

		DragPoint.InputChanged:Connect(function(Input)
			if (Input.UserInputType == Enum.UserInputType.MouseMovement or Input.UserInputType == Enum.UserInputType.Touch) then
				DragInput = Input
			end
		end)

		UserInputService.InputChanged:Connect(function(Input)
			if Input == DragInput and Dragging then
				local Delta = Input.Position - MousePos

				TweenService:Create(Main, TweenInfo.new(0.45, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Position = UDim2.new(FramePos.X.Scale, FramePos.X.Offset + Delta.X, FramePos.Y.Scale, FramePos.Y.Offset + Delta.Y)}):Play()
				TweenService:Create(InfoPrompt, TweenInfo.new(0.6, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Position = UDim2.new(FramePos.X.Scale, FramePos.X.Offset + Delta.X + 370, FramePos.Y.Scale, FramePos.Y.Offset + Delta.Y)}):Play()
			end
		end)
	end)
end

function BoolToText(Bool)
	if Bool == true then
		return 'ENABLED', Color3.fromRGB(44, 186, 44)
	else
		return 'DISABLED', Color3.fromRGB(186, 44, 44)
	end
end

local function FadeDescription(Infos, Type, Out)
	local Size = UDim2.fromOffset(230, 275)
	local Transparency = 0
	local WaitTime = .05

	if Out then
		Size = UDim2.fromOffset(212, 254)
		Transparency = 1
		WaitTime = nil
	end

	if not Out then
		if Type == 'slider' then
			InfoPrompt.Status.Text = Infos.CurrentValue
		elseif Type == 'button' then
			InfoPrompt.Status.Text = 'Clickable'
		elseif Type == 'toggle' then
			InfoPrompt.Status.Text, InfoPrompt.Status.TextColor3 = BoolToText(Infos.CurrentValue)
		elseif Type == 'colorpicker' then
			InfoPrompt.Status.Text = Infos.Color.R .. Infos.Color.G .. Infos.Color.B
		end

		if Infos and Infos["Info"] and not Infos.Info["Image"] then
			InfoPrompt.ImageLabel.Visible = false
			InfoPrompt.Description.Position = InfoPrompt.ImageLabel.Position
		elseif Infos and Infos["Info"] and Infos.Info["Image"] then
			InfoPrompt.ImageLabel.Visible = true
			InfoPrompt.ImageLabel.Image = 'rbxassetid://' .. Infos.Info["Image"]
			InfoPrompt.Description.Position = UDim2.new(.5, 0, 0, 160)
		end

		if Infos and Infos["Info"] then
			InfoPrompt.Title.Text = Infos.Info.Title
			InfoPrompt.Description.Text = Infos.Info.Description
		end
	end

	TweenService:Create(InfoPrompt, TweenInfo.new(.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
		Size = Size,
		BackgroundTransparency = Transparency
	}):Play()
	
	TweenService:Create(InfoPrompt.ImageLabel, TweenInfo.new(.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
		ImageTransparency = Transparency
	}):Play()
	
	TweenService:Create(InfoPrompt.Description, TweenInfo.new(.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
		TextTransparency = Transparency
	}):Play()
	
	TweenService:Create(InfoPrompt.Status, TweenInfo.new(.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
		TextTransparency = Transparency
	}):Play()
	
	TweenService:Create(InfoPrompt.Title, TweenInfo.new(.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
		TextTransparency = Transparency
	}):Play()
end

function AddInfos(Object, Settings, Type)
	Object.MouseEnter:Connect(function(Input)
		if Settings and Settings.Info then
			InfoPromptOpen = true
			FadeDescription(Settings, Type)
		end
	end)

	Object.MouseLeave:Connect(function()
		FadeDescription(nil, nil, true)
	end)
end

local function PackColor(Color)
	return {R = Color.R * 255, G = Color.G * 255, B = Color.B * 255}
end    

local function UnpackColor(Color)
	return Color3.fromRGB(Color.R, Color.G, Color.B)
end

local function LoadConfiguration(Configuration)
	local Data = HttpService:JSONDecode(Configuration)

	for FlagName, FlagValue in next, Data do
		if SsamachiLibrary.Flags[FlagName] then
			Spawn(function() 
				if SsamachiLibrary.Flags[FlagName].Type == "ColorPicker" then
					SsamachiLibrary.Flags[FlagName]:Set(UnpackColor(FlagValue))
				else
					if SsamachiLibrary.Flags[FlagName].CurrentValue or SsamachiLibrary.Flags[FlagName].CurrentKeybind or SsamachiLibrary.Flags[FlagName].CurrentOption or SsamachiLibrary.Flags[FlagName].Color ~= FlagValue then
						SsamachiLibrary.Flags[FlagName]:Set(FlagValue)
					end
				end    
			end)
		end
	end
end

local function SaveConfiguration()
	if not CEnabled then
		return
	end

	local Data = {}

	for I, V in pairs(SsamachiLibrary.Flags) do
		if V.Type == "ColorPicker" then
			Data[I] = PackColor(V.Color)
		else
			Data[I] = V.CurrentValue or V.CurrentKeybind or V.Color or V.CurrentOption
		end
	end	

	writefile(ConfigurationFolder .. "/" .. CFileName .. ConfigurationExtension, tostring(HttpService:JSONEncode(Data)))
end

local Neon = (function()
	local Module = {}

	do
		local function IsNotNaN(X)
			return X == X
		end

		local Continued = IsNotNaN(Camera:ScreenPointToRay(0, 0).Origin.x)

		while not Continued do
			RunService.RenderStepped:wait()
			Continued = IsNotNaN(Camera:ScreenPointToRay(0, 0).Origin.x)
		end
	end

	local RootParent = Camera

	if false == nil then
		RootParent = Camera
	else
		if not false then
			RootParent = Camera
		else 
			RootParent = nil
		end
	end

	local Binds = {}
	local Root = Instance.new('Folder', RootParent)
	Root.Name = 'neon'

	local GenUid
	do
		local Id = 0

		function GenUid()
			Id = Id + 1
			return 'neon::' .. tostring(Id)
		end
	end

	local DrawQuad
	do
		local Acos, Max, Pi, Sqrt = math.acos, math.max, math.pi, math.sqrt
		local Sz = 0.2

		local function DrawTriangle(V1, V2, V3, P0, P1)
			local S1 = (V1 - V2).magnitude
			local S2 = (V2 - V3).magnitude
			local S3 = (V3 - V1).magnitude
			local Smax = Max(S1, S2, S3)
			local A, B, C

			if S1 == Smax then
				A, B, C = V1, V2, V3
			elseif S2 == Smax then
				A, B, C = V2, V3, V1
			elseif S3 == Smax then
				A, B, C = V3, V1, V2
			end

			local Para = ((B - A).x * (C - A).x + (B - A).y * (C - A).y + (B - A).z * (C - A).z) / (A - B).magnitude
			local Perp = Sqrt((C - A).magnitude ^ 2 - Para * Para)
			local DifPara = (A - B).magnitude - Para

			local St = CFrame.new(B, A)
			local Za = CFrame.Angles(Pi / 2, 0, 0)

			local Cf0 = St
			local TopLook = (Cf0 * Za).lookVector
			local MidPoint = A + CFrame.new(A, B).LookVector * Para
			local NeededLook = CFrame.new(MidPoint, C).LookVector
			local Dot = TopLook.x * NeededLook.x + TopLook.y * NeededLook.y + TopLook.z * NeededLook.z

			local Ac = CFrame.Angles(0, 0, Acos(Dot))
			Cf0 = Cf0 * Ac

			if ((Cf0 * Za).lookVector - NeededLook).magnitude > 0.01 then
				Cf0 = Cf0 * CFrame.Angles(0, 0, -2 * Acos(Dot))
			end

			Cf0 = Cf0 * CFrame.new(0, Perp / 2, -(DifPara + Para / 2))

			local Cf1 = St * Ac * CFrame.Angles(0, Pi, 0)

			if ((Cf1 * Za).lookVector - NeededLook).magnitude > 0.01 then
				Cf1 = Cf1 * CFrame.Angles(0, 0, 2 * Acos(Dot))
			end

			Cf1 = Cf1 * CFrame.new(0, Perp / 2, DifPara / 2)

			if not P0 then
				P0 = Instance.new('Part')
				P0.FormFactor = 'Custom'
				P0.TopSurface = 0
				P0.BottomSurface = 0
				P0.Anchored = true
				P0.CanCollide = false
				P0.Material = 'Glass'
				P0.Size = Vector3.new(Sz, Sz, Sz)
				local Mesh = Instance.new('SpecialMesh', P0)
				Mesh.MeshType = 2
				Mesh.Name = 'WedgeMesh'
			end

			P0.WedgeMesh.Scale = Vector3.new(0, Perp / Sz, Para / Sz)
			P0.CFrame = Cf0

			if not P1 then
				P1 = P0:clone()
			end

			P1.WedgeMesh.Scale = Vector3.new(0, Perp / Sz, DifPara / Sz)
			P1.CFrame = Cf1

			return P0, P1
		end

		function DrawQuad(V1, V2, V3, V4, Parts)
			Parts[1], Parts[2] = DrawTriangle(V1, V2, V3, Parts[1], Parts[2])
			Parts[3], Parts[4] = DrawTriangle(V3, V2, V4, Parts[3], Parts[4])
		end
	end

	function Module:BindFrame(Frame, Properties)
		if RootParent == nil then
			return
		end

		if Binds[Frame] then
			return Binds[Frame].parts
		end

		local Uid = GenUid()
		local Parts = {}
		local F = Instance.new('Folder', Root)
		F.Name = Frame.Name
		local Parents = {}

		do
			local function Add(Child)
				if Child:IsA('GuiObject') then
					Parents[#Parents + 1] = Child
					Add(Child.Parent)
				end
			end
			Add(Frame)
		end

		local function UpdateOrientation(FetchProps)
			local ZIndex = 1 - 0.05 * Frame.ZIndex
			local Tl, Br = Frame.AbsolutePosition, Frame.AbsolutePosition + Frame.AbsoluteSize
			local Tr, Bl = Vector2.new(Br.x, Tl.y), Vector2.new(Tl.x, Br.y)

			do
				local Rot = 0

				for _, V in ipairs(Parents) do
					Rot = Rot + V.Rotation
				end

				if Rot ~= 0 and Rot % 180 ~= 0 then
					local Mid = Tl:lerp(Br, 0.5)
					local S, C = math.sin(math.rad(Rot)), math.cos(math.rad(Rot))
					local Vec = Tl
					Tl = Vector2.new(C * (Vec.x - Mid.x) - S * (Vec.y - Mid.y), S * (Vec.x - Mid.x) + C * (Vec.y - Mid.y)) + Mid
					Tr = Vector2.new(C * (Tr.x - Mid.x) - S * (Tr.y - Mid.y), S * (Tr.x - Mid.x) + C * (Tr.y - Mid.y)) + Mid
					Bl = Vector2.new(C * (Bl.x - Mid.x) - S * (Bl.y - Mid.y), S * (Bl.x - Mid.x) + C * (Bl.y - Mid.y)) + Mid
					Br = Vector2.new(C * (Br.x - Mid.x) - S * (Br.y - Mid.y), S * (Br.x - Mid.x) + C * (Br.y - Mid.y)) + Mid
				end
			end

			DrawQuad(
				Camera:ScreenPointToRay(Tl.x, Tl.y, ZIndex).Origin, 
				Camera:ScreenPointToRay(Tr.x, Tr.y, ZIndex).Origin, 
				Camera:ScreenPointToRay(Bl.x, Bl.y, ZIndex).Origin, 
				Camera:ScreenPointToRay(Br.x, Br.y, ZIndex).Origin, 
				Parts
			)

			if FetchProps then
				for _, Pt in pairs(Parts) do
					Pt.Parent = F
				end

				for PropName, PropValue in pairs(Properties) do
					for _, Pt in pairs(Parts) do
						Pt[PropName] = PropValue
					end
				end
			end
		end

		UpdateOrientation(true)
		RunService:BindToRenderStep(Uid, 2000, UpdateOrientation)

		Binds[Frame] = {
			uid = Uid,
			parts = Parts,
		}

		return Binds[Frame].parts
	end

	function Module:Modify(Frame, Properties)
		local Parts = Module:GetBoundParts(Frame)

		if Parts then
			for PropName, PropValue in pairs(Properties) do
				for _, Pt in pairs(Parts) do
					Pt[PropName] = PropValue
				end
			end
		end
	end

	function Module:UnbindFrame(Frame)
		if RootParent == nil then
			return
		end

		local Cb = Binds[Frame]

		if Cb then
			RunService:UnbindFromRenderStep(Cb.uid)

			for _, V in pairs(Cb.parts) do
				V:Destroy()
			end

			Binds[Frame] = nil
		end
	end

	function Module:HasBinding(Frame)
		return Binds[Frame] ~= nil
	end

	function Module:GetBoundParts(Frame)
		return Binds[Frame] and Binds[Frame].parts
	end

	return Module
end)()

function CloseNPrompt()
	local Infos = TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

	TweenService:Create(NotePrompt, Infos, {BackgroundTransparency = 1, Size = UDim2.fromOffset(436, 92), Position = UDim2.fromScale(0.5, 0.19)}):Play()
	TweenService:Create(NotePrompt.UIStroke, Infos, {Transparency = 1}):Play()
	TweenService:Create(NotePrompt.Shadow.Image, Infos, {ImageTransparency = 1}):Play()

	TweenService:Create(NotePrompt.Close, Infos, {ImageTransparency = .1}):Play()
	TweenService:Create(NotePrompt.Icon, Infos, {ImageTransparency = 1}):Play()
	TweenService:Create(NotePrompt.Title, Infos, {TextTransparency = 1}):Play()

	TweenService:Create(NotePrompt.Description, Infos, {TextTransparency = 1}):Play()
	TweenService:Create(NotePrompt.Load, Infos, {TextTransparency = 1, BackgroundTransparency = 1}):Play()
	TweenService:Create(NotePrompt.Load.UIStroke, Infos, {Transparency = 1}):Play()
	TweenService:Create(NotePrompt.Load.Shadow, Infos, {ImageTransparency = 1}):Play()
	
	wait(0.21)
	NotePrompt.Visible = false
end

function qNotePrompt(PromptSettings)
	local Infos = TweenInfo.new(.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
	NotePrompt.Visible = false

	NotePrompt.Size = UDim2.fromOffset(436, 92)
	NotePrompt.Position = UDim2.fromScale(0.5, 0.19)
	NotePrompt.BackgroundTransparency = 1
	NotePrompt.UIStroke.Transparency = 1

	NotePrompt.Icon.ImageTransparency = 1
	NotePrompt.Close.ImageTransparency = 1

	NotePrompt.Shadow.Image.ImageTransparency = 1

	NotePrompt.Title.TextTransparency = 1
	NotePrompt.Description.TextTransparency = 1

	NotePrompt.Load.BackgroundTransparency = 1
	NotePrompt.Load.UIStroke.Transparency = 1
	NotePrompt.Load.TextTransparency = 1
	NotePrompt.Load.Shadow.ImageTransparency = 1
	
	NotePrompt.Title.Text = PromptSettings.Title or ''
	NotePrompt.Description.Text = PromptSettings.Description or ''
	NotePrompt.Icon.Image = PromptSettings.Icon or 'rbxassetid://4483362748'
	NotePrompt.Load.BackgroundColor3 = PromptSettings.Color or Color3.fromRGB(90, 90, 90)
	
	NotePrompt.Load.MouseButton1Down:Once(function(X, Y)
		CloseNPrompt()

		if PromptSettings.Callback then
			PromptSettings.Callback()
		end
	end)

	NotePrompt.Close.MouseButton1Down:Once(function()
		CloseNPrompt()
	end)

	NotePrompt.Visible = true

	TweenService:Create(NotePrompt, Infos, {BackgroundTransparency = .1, Size = UDim2.fromOffset(474, 100), Position = UDim2.fromScale(0.5, 0.21)}):Play()
	TweenService:Create(NotePrompt.UIStroke, Infos, {Transparency = 0}):Play()
	TweenService:Create(NotePrompt.Shadow.Image, Infos, {ImageTransparency = .2}):Play()
	
	wait(.3)
	
	TweenService:Create(NotePrompt.Close, Infos, {ImageTransparency = .8}):Play()
	TweenService:Create(NotePrompt.Icon, Infos, {ImageTransparency = 0}):Play()
	TweenService:Create(NotePrompt.Title, Infos, {TextTransparency = 0}):Play()
	
	wait(.1)
	
	TweenService:Create(NotePrompt.Description, Infos, {TextTransparency = 0}):Play()
	
	wait(.2)
	
	TweenService:Create(NotePrompt.Load, Infos, {TextTransparency = 0, BackgroundTransparency = .2}):Play()
	TweenService:Create(NotePrompt.Load.UIStroke, Infos, {Transparency = 0}):Play()
	TweenService:Create(NotePrompt.Load.Shadow, Infos, {ImageTransparency = .8}):Play()
end

function ClosePrompt()
	local PromptUI = Prompt.Prompt
	Clicked = false

	TweenService:Create(Prompt, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {BackgroundTransparency = 1}):Play()
	TweenService:Create(PromptUI, TweenInfo.new(0.4, Enum.EasingStyle.Quint), {BackgroundTransparency = 1, Size = UDim2.new(0, 340, 0, 140)}):Play()
	TweenService:Create(PromptUI.UIStroke, TweenInfo.new(0.4, Enum.EasingStyle.Quint), {Transparency = 1}):Play()
	TweenService:Create(PromptUI.Title, TweenInfo.new(0.45, Enum.EasingStyle.Quint), {TextTransparency = 1}):Play()
	TweenService:Create(PromptUI.Content, TweenInfo.new(0.45, Enum.EasingStyle.Quint), {TextTransparency = 1}):Play()
	TweenService:Create(PromptUI.Sub, TweenInfo.new(0.45, Enum.EasingStyle.Quint), {TextTransparency = 1}):Play()

	for _, Button in pairs(PromptUI.Buttons:GetChildren()) do
		if Button.Name ~= 'Template' and Button:IsA("Frame") then
			TweenService:Create(Button.UIStroke, TweenInfo.new(0.2, Enum.EasingStyle.Quint), {Transparency = 1}):Play()
			TweenService:Create(Button.TextLabel, TweenInfo.new(0.2, Enum.EasingStyle.Quint), {TextTransparency = 1}):Play()
			Delay(.2, function()
				Button:Destroy()
			end)
		end
	end

	wait(.5)
	Prompt.Visible = false
end

function SsamachiLibrary:Notify(NotificationSettings)
	Spawn(function()
		local ActionCompleted = true
		local Notification = Notifications.Template:Clone()
		Notification.Parent = Notifications
		Notification.Active = false
		Notification.Name = NotificationSettings.Title or "Unknown Title"
		Notification.Visible = true

		local BlurLight = nil

		if not false then
			BlurLight = Instance.new("DepthOfFieldEffect", game:GetService("Lighting"))
			BlurLight.Enabled = true
			BlurLight.FarIntensity = 0
			BlurLight.FocusDistance = 51.6
			BlurLight.InFocusRadius = 50
			BlurLight.NearIntensity = 1
			if script then game:GetService("Debris"):AddItem(script, 0) end
		end

		Notification.Actions.Template.Visible = false

		if NotificationSettings.Actions then
			for _, Action in pairs(NotificationSettings.Actions) do
				ActionCompleted = false
				local NewAction = Notification.Actions.Template:Clone()
				NewAction.Active = false
				NewAction.BackgroundColor3 = SelectedTheme.NotificationActionsBackground

				if SelectedTheme ~= SsamachiLibrary.Theme.Default then
					NewAction.TextColor3 = SelectedTheme.TextColor
				end
				
				NewAction.Name = Action.Name
				NewAction.Visible = true
				NewAction.Parent = Notification.Actions
				NewAction.Text = Action.Name
				NewAction.BackgroundTransparency = 1
				NewAction.TextTransparency = 1
				NewAction.Size = UDim2.new(0, NewAction.TextBounds.X + 27, 0, 36)

				NewAction.MouseButton1Click:Connect(function()
					local Success, Response = pcall(Action.Callback)
					if not Success then
						print("Ssamachi | Action: " .. Action.Name .. " Callback Error " .. tostring(Response))
					end
					ActionCompleted = true
				end)
			end
		end
		
		Notification.BackgroundColor3 = SelectedTheme.Background
		Notification.Title.Text = NotificationSettings.Title or "Unknown"
		Notification.Title.TextTransparency = 1
		Notification.Title.TextColor3 = SelectedTheme.TextColor
		Notification.Description.Text = NotificationSettings.Content or "Unknown"
		Notification.Description.TextTransparency = 1
		Notification.Description.TextColor3 = SelectedTheme.TextColor
		Notification.Icon.ImageColor3 = SelectedTheme.TextColor
		
		if NotificationSettings.Image then
			Notification.Icon.Image = "rbxassetid://" .. tostring(NotificationSettings.Image) 
		else
			Notification.Icon.Image = "rbxassetid://3944680095"
		end

		Notification.Icon.ImageTransparency = 1

		Notification.Parent = Notifications
		Notification.Size = UDim2.new(0, 260, 0, 80)
		Notification.BackgroundTransparency = 1
		
		for I, V in pairs(Notification:GetDescendants()) do
			if V:IsA("GuiObject") and V.Active then
				V.Active = false
			end
		end

		TweenService:Create(Notification, TweenInfo.new(0.7, Enum.EasingStyle.Quint), {Size = UDim2.new(0, 295, 0, 91)}):Play()
		TweenService:Create(Notification, TweenInfo.new(0.7, Enum.EasingStyle.Quint), {BackgroundTransparency = 0.1}):Play()
		Notification:TweenPosition(UDim2.new(0.5, 0, 0.915, 0), 'Out', 'Quint', 0.8, true)

		wait(0.3)
		
		TweenService:Create(Notification.Icon, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {ImageTransparency = 0}):Play()
		TweenService:Create(Notification.Title, TweenInfo.new(0.7, Enum.EasingStyle.Quint), {TextTransparency = 0}):Play()
		TweenService:Create(Notification.Description, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {TextTransparency = 0.2}):Play()
		
		wait(0.2)

		if false == nil then
			TweenService:Create(Notification, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {BackgroundTransparency = 0.4}):Play()
		else
			if not false then
				TweenService:Create(Notification, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {BackgroundTransparency = 0.4}):Play()
			else 
				TweenService:Create(Notification, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {BackgroundTransparency = 0}):Play()
			end
		end

		if Ssamachi.Name == "Ssamachi" then
			Neon:BindFrame(Notification.BlurModule, {
				Transparency = 0.98,
				BrickColor = BrickColor.new("Institutional white"),
			})
		end

		if not NotificationSettings.Actions then
			wait(NotificationSettings.Duration or NotificationDuration - 0.5)
		else
			wait(0.8)
			
			TweenService:Create(Notification, TweenInfo.new(0.7, Enum.EasingStyle.Quint), {Size = UDim2.new(0, 295, 0, 132)}):Play()
			
			wait(0.3)

			for _, Action in ipairs(Notification.Actions:GetChildren()) do
				if Action.ClassName == "TextButton" and Action.Name ~= "Template" then
					TweenService:Create(Action, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {BackgroundTransparency = 0.2}):Play()
					TweenService:Create(Action, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {TextTransparency = 0}):Play()
					wait(0.05)
				end
			end
		end

		repeat
			wait(0.001)
		until ActionCompleted

		for _, Action in ipairs(Notification.Actions:GetChildren()) do
			if Action.ClassName == "TextButton" and Action.Name ~= "Template" then
				TweenService:Create(Action, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {BackgroundTransparency = 1}):Play()
				TweenService:Create(Action, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {TextTransparency = 1}):Play()
			end
		end

		TweenService:Create(Notification.Title, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {Position = UDim2.new(0.47, 0, 0.234, 0)}):Play()
		TweenService:Create(Notification.Description, TweenInfo.new(0.8, Enum.EasingStyle.Quint), {Position = UDim2.new(0.528, 0, 0.637, 0)}):Play()
		TweenService:Create(Notification, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {Size = UDim2.new(0, 280, 0, 83)}):Play()
		TweenService:Create(Notification.Icon, TweenInfo.new(0.4, Enum.EasingStyle.Quint), {ImageTransparency = 1}):Play()
		TweenService:Create(Notification, TweenInfo.new(0.8, Enum.EasingStyle.Quint), {BackgroundTransparency = 0.6}):Play()

		wait(0.3)
		
		TweenService:Create(Notification.Title, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {TextTransparency = 0.4}):Play()
		TweenService:Create(Notification.Description, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {TextTransparency = 0.5}):Play()
		
		wait(0.4)
		
		TweenService:Create(Notification, TweenInfo.new(0.9, Enum.EasingStyle.Quint), {Size = UDim2.new(0, 260, 0, 0)}):Play()
		TweenService:Create(Notification, TweenInfo.new(0.8, Enum.EasingStyle.Quint), {BackgroundTransparency = 1}):Play()
		TweenService:Create(Notification.Title, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {TextTransparency = 1}):Play()
		TweenService:Create(Notification.Description, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {TextTransparency = 1}):Play()
		
		wait(0.2)
		
		if not false then
			Neon:UnbindFrame(Notification.BlurModule)
			BlurLight:Destroy()
		end
		
		wait(0.9)
		Notification:Destroy()
	end)
end

function CloseSideBar()
	Debounce = true
	SideBarClosed = true

	for _, TabBtn in pairs(SideList:GetChildren()) do
		if TabBtn.ClassName == "Frame" and TabBtn.Name ~= "Placeholder" then
			TweenService:Create(TabBtn.Title, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {TextTransparency = 1}):Play()
			TweenService:Create(TabBtn.Image, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {ImageTransparency = 1}):Play()
		end
	end

	TweenService:Create(Main.SideTabList, TweenInfo.new(0.4, Enum.EasingStyle.Quint), {BackgroundTransparency = 1, Size = UDim2.new(0, 150, 0, 390), Position = UDim2.new(0, 10, 0.5, 22)}):Play()
	TweenService:Create(Main.SideTabList.UIStroke, TweenInfo.new(0.4, Enum.EasingStyle.Quint), {Transparency = 1}):Play()
	TweenService:Create(Main.SideTabList.RDMT, TweenInfo.new(0.4, Enum.EasingStyle.Quint), {TextTransparency = 1}):Play()
	
	wait(.4)
	
	Main.SideTabList.Visible = false
	
	wait(0.2)
	Debounce = false
end

function Hide()
	if not SideBarClosed then
		Spawn(CloseSideBar)
	end

	Spawn(function()
		FadeDescription(nil, true, true)
	end)

	Debounce = true
	
	TweenService:Create(Main, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {Size = UDim2.new(0, 470, 0, 400)}):Play()
	TweenService:Create(Main.Topbar, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {Size = UDim2.new(0, 470, 0, 45)}):Play()
	TweenService:Create(Main, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {BackgroundTransparency = 1}):Play()
	TweenService:Create(Main.Topbar, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {BackgroundTransparency = 1}):Play()
	TweenService:Create(Main.Topbar.Divider, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {BackgroundTransparency = 1}):Play()
	TweenService:Create(Main.Topbar.CornerRepair, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {BackgroundTransparency = 1}):Play()
	TweenService:Create(Main.Topbar.Title, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {TextTransparency = 1}):Play()
	TweenService:Create(Main.Shadow.Image, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {ImageTransparency = 1}):Play()
	TweenService:Create(Topbar.UIStroke, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {Transparency = 1}):Play()

	for _, TopbarButton in ipairs(Topbar:GetChildren()) do
		if TopbarButton.ClassName == "ImageButton" then
			TweenService:Create(TopbarButton, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {ImageTransparency = 1}):Play()
		end
	end

	for _, TabBtn in ipairs(TabsList:GetChildren()) do
		if TabBtn.ClassName == "Frame" and TabBtn.Name ~= "Placeholder" then
			TweenService:Create(TabBtn, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {BackgroundTransparency = 1}):Play()
			TweenService:Create(TabBtn.Title, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {TextTransparency = 1}):Play()
			TweenService:Create(TabBtn.Image, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {ImageTransparency = 1}):Play()
			TweenService:Create(TabBtn.Shadow, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {ImageTransparency = 1}):Play()
			TweenService:Create(TabBtn.UIStroke, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {Transparency = 1}):Play()
		end
	end

	for _, Tab in ipairs(Elements:GetChildren()) do
		if Tab.Name ~= "Template" and Tab.ClassName == "ScrollingFrame" and Tab.Name ~= "Placeholder" then
			for _, Element in ipairs(Tab:GetChildren()) do
				if Element.ClassName == "Frame" then
					if Element.Name ~= "SectionSpacing" and Element.Name ~= "Placeholder" then
						if Element:FindFirstChild('Holder') then
							TweenService:Create(Element, TweenInfo.new(0.2, Enum.EasingStyle.Quint), {BackgroundTransparency = 1}):Play()
							TweenService:Create(Element.Title, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {TextTransparency = 1}):Play()
						else
							TweenService:Create(Element, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {BackgroundTransparency = 1}):Play()
							pcall(function()
								TweenService:Create(Element.UIStroke, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {Transparency = 1}):Play()
							end)
							TweenService:Create(Element.Title, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {TextTransparency = 1}):Play()
						end
						
						for _, Child in ipairs(Element:GetChildren()) do
							if Child.ClassName == "Frame" or Child.ClassName == "TextLabel" or Child.ClassName == "TextBox" or Child.ClassName == "ImageButton" or Child.ClassName == "ImageLabel" then
								Child.Visible = false
							end
						end
					end
				end
			end
		end
	end

	wait(0.5)
	
	Main.Visible = false
	Debounce = false
end

function Unhide()
	Debounce = true
	Main.Position = UDim2.new(0.5, 0, 0.5, 0)
	Main.Visible = true
	
	TweenService:Create(Main, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {Size = UDim2.new(0, 500, 0, 475)}):Play()
	TweenService:Create(Main.Topbar, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {Size = UDim2.new(0, 500, 0, 45)}):Play()
	TweenService:Create(Main.Shadow.Image, TweenInfo.new(0.7, Enum.EasingStyle.Quint), {ImageTransparency = 0.4}):Play()
	TweenService:Create(Main, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {BackgroundTransparency = 0}):Play()
	TweenService:Create(Main.Topbar, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {BackgroundTransparency = 0}):Play()
	TweenService:Create(Main.Topbar.Divider, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {BackgroundTransparency = 0}):Play()
	TweenService:Create(Main.Topbar.CornerRepair, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {BackgroundTransparency = 0}):Play()
	TweenService:Create(Main.Topbar.Title, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {TextTransparency = 0}):Play()

	if Minimised then
		Spawn(Maximise)
	end

	for _, TopbarButton in ipairs(Topbar:GetChildren()) do
		if TopbarButton.ClassName == "ImageButton" then
			TweenService:Create(TopbarButton, TweenInfo.new(0.7, Enum.EasingStyle.Quint), {ImageTransparency = 0.8}):Play()
		end
	end
	
	for _, Tab in ipairs(Elements:GetChildren()) do
		if Tab.Name ~= "Template" and Tab.ClassName == "ScrollingFrame" and Tab.Name ~= "Placeholder" then
			for _, Element in ipairs(Tab:GetChildren()) do
				if Element.ClassName == "Frame" then
					if Element.Name ~= "SectionSpacing" and Element.Name ~= "Placeholder" and not Element:FindFirstChild('ColorPickerIs') then
						if Element:FindFirstChild('_UIPadding_') then
							TweenService:Create(Element.Title, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {TextTransparency = 0}):Play()
							TweenService:Create(Element, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {BackgroundTransparency = .25}):Play()
						else
							if Element.Name ~= 'SectionTitle' then
								TweenService:Create(Element, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {BackgroundTransparency = 0}):Play()
								TweenService:Create(Element.UIStroke, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {Transparency = 0}):Play()
							end
							TweenService:Create(Element.Title, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {TextTransparency = 0}):Play()
						end
						
						for _, Child in ipairs(Element:GetChildren()) do
							if (Child.ClassName == "Frame" or Child.ClassName == "TextLabel" or Child.ClassName == "TextBox" or Child.ClassName == "ImageButton" or Child.ClassName == "ImageLabel") then
								Child.Visible = true
							end
						end
					elseif Element:FindFirstChild('ColorPickerIs') then
						TweenService:Create(Element, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {BackgroundTransparency = 0}):Play()
						TweenService:Create(Element.UIStroke, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {Transparency = 0}):Play()
						TweenService:Create(Element.Title, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {TextTransparency = 0}):Play()

						if Element.ColorPickerIs.Value then
							Element.ColorSlider.Visible = true
							Element.HexInput.Visible = true
							Element.RGB.Visible = true
						end
						
						Element.CPBackground.Visible = true
						Element.Lock.Visible = true
						Element.Interact.Visible = true
						Element.Title.Visible = true
					end
				end
			end
		end
	end
	
	wait(0.5)
	
	Minimised = false
	Debounce = false
end

function CloseSearch()
	Debounce = true
	
	TweenService:Create(SearchBar, TweenInfo.new(0.4, Enum.EasingStyle.Quint), {BackgroundTransparency = 1, Size = UDim2.new(0, 460, 0, 35)}):Play()
	TweenService:Create(SearchBar.Icon, TweenInfo.new(0.4, Enum.EasingStyle.Quint), {ImageTransparency = 1}):Play()
	TweenService:Create(SearchBar.Clear, TweenInfo.new(0.4, Enum.EasingStyle.Quint), {ImageTransparency = 1}):Play()
	TweenService:Create(SearchBar.UIStroke, TweenInfo.new(0.4, Enum.EasingStyle.Quint), {Transparency = 1}):Play()
	TweenService:Create(SearchBar.Filter, TweenInfo.new(0.4, Enum.EasingStyle.Quint), {ImageTransparency = 1}):Play()
	TweenService:Create(SearchBar.Shadow.Image, TweenInfo.new(0.4, Enum.EasingStyle.Quint), {ImageTransparency = 0.1}):Play()
	TweenService:Create(SearchBar.Input, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {TextTransparency = 1}):Play()
	
	Delay(.3, function()
		SearchBar.Input.Visible = false
		SearchBar.Input.Active = false
		SearchBar.Input.ClearTextOnFocus = true
	end)
	
	wait(0.5)
	
	SearchBar.Visible = false
	Debounce = false
end

function OpenSearch()
	Debounce = true
	SearchBar.Visible = true
	SearchBar.Input.Visible = true
	SearchBar.Input.ClearTextOnFocus = false
	SearchBar.Input.Active = true
	
	TweenService:Create(SearchBar, TweenInfo.new(0.4, Enum.EasingStyle.Quint), {BackgroundTransparency = 0, Size = UDim2.new(0, 480, 0, 40)}):Play()
	TweenService:Create(SearchBar.Icon, TweenInfo.new(0.4, Enum.EasingStyle.Quint), {ImageTransparency = 0.5}):Play()
	TweenService:Create(SearchBar.Shadow.Image, TweenInfo.new(0.4, Enum.EasingStyle.Quint), {ImageTransparency = 0.1}):Play()
	TweenService:Create(SearchBar.UIStroke, TweenInfo.new(0.4, Enum.EasingStyle.Quint), {Transparency = 0}):Play()
	TweenService:Create(SearchBar.Clear, TweenInfo.new(0.4, Enum.EasingStyle.Quint), {ImageTransparency = .8}):Play()
	TweenService:Create(SearchBar.Filter, TweenInfo.new(0.4, Enum.EasingStyle.Quint), {ImageTransparency = .8}):Play()
	TweenService:Create(SearchBar.Input, TweenInfo.new(0.4, Enum.EasingStyle.Quint), {TextTransparency = 0}):Play()
	
	wait(0.5)
	Debounce = false
end

SearchBar.Input:GetPropertyChangedSignal('Text'):Connect(function()
	local InputText = string.upper(SearchBar.Input.Text)
	
	for _, Page in ipairs(Elements:GetChildren()) do
		if Page ~= 'Template' then
			for _, Element in pairs(Page:GetChildren()) do
				if Element:IsA("Frame") and Element.Name ~= 'Placeholder' and Element.Name ~= 'SectionSpacing' then
					if InputText == "" or string.find(string.upper(Element.Name), InputText) ~= nil then
						Element.Visible = true
					else
						Element.Visible = false
					end
				end
			end
		end
	end
end)

SearchBar.Clear.MouseButton1Down:Connect(function()
	Filler.Position = UDim2.new(0.957, 0, .5, 0)
	Filler.Size = UDim2.new(0, 1, 0, 1)
	Filler.BackgroundTransparency = .9

	local Goal = {}
	Goal.Size = UDim2.new(0, 1000, 0, 500)
	Goal.BackgroundTransparency = 1

	TweenService:Create(Filler, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), Goal):Play()
	SearchBar.Input.Text = ''
end)

function Maximise()
	Debounce = true
	Topbar.ChangeSize.Image = "rbxassetid://" .. 10137941941

	TweenService:Create(Topbar.UIStroke, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {Transparency = 1}):Play()
	TweenService:Create(Main.Shadow.Image, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {ImageTransparency = 0.4}):Play()
	TweenService:Create(Topbar.CornerRepair, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {BackgroundTransparency = 0}):Play()
	TweenService:Create(Topbar.Divider, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {BackgroundTransparency = 0}):Play()
	TweenService:Create(Main, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {Size = UDim2.new(0, 500, 0, 475)}):Play()
	TweenService:Create(Topbar, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {Size = UDim2.new(0, 500, 0, 45)}):Play()
	
	TabsList.Visible = true
	
	wait(0.2)

	Elements.Visible = true

	for _, Tab in ipairs(Elements:GetChildren()) do
		if Tab.Name ~= "Template" and Tab.ClassName == "ScrollingFrame" and Tab.Name ~= "Placeholder" then
			for _, Element in ipairs(Tab:GetChildren()) do
				if Element.ClassName == "Frame" then
					if Element.Name ~= "SectionSpacing" and Element.Name ~= "Placeholder" and not Element:FindFirstChild('ColorPickerIs') then
						if Element:FindFirstChild('_UIPadding_') then
							TweenService:Create(Element, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {BackgroundTransparency = .25}):Play()
							TweenService:Create(Element.Title, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {TextTransparency = 0}):Play()
						else
							if Element.Name ~= 'SectionTitle' then
								TweenService:Create(Element, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {BackgroundTransparency = 0}):Play()
								TweenService:Create(Element.UIStroke, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {Transparency = 0}):Play()
							end
							TweenService:Create(Element.Title, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {TextTransparency = 0}):Play()
						end
						
						for _, Child in ipairs(Element:GetChildren()) do
							if (Child.ClassName == "Frame" or Child.ClassName == "TextLabel" or Child.ClassName == "TextBox" or Child.ClassName == "ImageButton" or Child.ClassName == "ImageLabel") then
								Child.Visible = true
							end
						end
					elseif Element:FindFirstChild('ColorPickerIs') then
						TweenService:Create(Element, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {BackgroundTransparency = 0}):Play()
						TweenService:Create(Element.UIStroke, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {Transparency = 0}):Play()
						TweenService:Create(Element.Title, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {TextTransparency = 0}):Play()

						if Element.ColorPickerIs.Value then
							Element.ColorSlider.Visible = true
							Element.HexInput.Visible = true
							Element.RGB.Visible = true
						end
						
						Element.CPBackground.Visible = true
						Element.Lock.Visible = true
						Element.Interact.Visible = true
						Element.Title.Visible = true
					end
				end
			end
		end
	end

	wait(0.1)

	for _, TabBtn in ipairs(TopList:GetChildren()) do
		if TabBtn.ClassName == "Frame" and TabBtn.Name ~= "Placeholder" then
			if tostring(Elements.UIPageLayout.CurrentPage) == TabBtn.Title.Text then
				TweenService:Create(TabBtn, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {BackgroundTransparency = 0}):Play()
				TweenService:Create(TabBtn.Image, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {ImageTransparency = 0}):Play()
				TweenService:Create(TabBtn.Title, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {TextTransparency = 0}):Play()
				TweenService:Create(TabBtn.UIStroke, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {Transparency = 1}):Play()
				TweenService:Create(TabBtn.Shadow, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {ImageTransparency = 0.9}):Play()
			else
				TweenService:Create(TabBtn, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {BackgroundTransparency = 0.7}):Play()
				TweenService:Create(TabBtn.Shadow, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {ImageTransparency = 0.7}):Play()
				TweenService:Create(TabBtn.Image, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {ImageTransparency = 0.2}):Play()
				TweenService:Create(TabBtn.Title, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {TextTransparency = 0.2}):Play()
				TweenService:Create(TabBtn.UIStroke, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {Transparency = 0}):Play()
			end
		end
	end

	wait(0.5)
	Debounce = false
end

function OpenSideBar()
	Debounce = true
	Main.SideTabList.Visible = true 
	
	TweenService:Create(Main.SideTabList, TweenInfo.new(0.4, Enum.EasingStyle.Quint), {BackgroundTransparency = .03, Size = UDim2.new(0, 160, 0, 405), Position = UDim2.new(0, 14, 0.5, 22)}):Play()
	TweenService:Create(Main.SideTabList.UIStroke, TweenInfo.new(0.4, Enum.EasingStyle.Quint), {Transparency = 0}):Play()
	TweenService:Create(Main.SideTabList.RDMT, TweenInfo.new(0.4, Enum.EasingStyle.Quint), {TextTransparency = 0}):Play()
	
	for _, TabBtn in pairs(SideList:GetChildren()) do
		if TabBtn.ClassName == "Frame" and TabBtn.Name ~= "Placeholder" then
			if TabBtn.Title.TextColor3 ~= Color3.fromRGB(255, 255, 255) then
				TweenService:Create(TabBtn.Title, TweenInfo.new(0.25, Enum.EasingStyle.Quint), {TextTransparency = .2}):Play()
			else
				TweenService:Create(TabBtn.Title, TweenInfo.new(0.25, Enum.EasingStyle.Quint), {TextTransparency = 0}):Play()
			end
			TweenService:Create(TabBtn.Image, TweenInfo.new(0.25, Enum.EasingStyle.Quint), {ImageTransparency = 0}):Play()
		end
		wait(0.12)
	end
	
	SideBarClosed = false
	
	wait(0.2)
	Debounce = false
end

function Minimise()
	Debounce = true
	Topbar.ChangeSize.Image = "rbxassetid://" .. 11036884234
	
	if not SearchHided then
		Spawn(CloseSearch)
	end
	
	if not SideBarClosed then
		Spawn(CloseSideBar)
	end
	
	Spawn(function()
		FadeDescription(nil, true, true)
	end)
	
	for _, TabBtn in ipairs(TopList:GetChildren()) do
		if TabBtn.ClassName == "Frame" and TabBtn.Name ~= "Placeholder" then
			TweenService:Create(TabBtn, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {BackgroundTransparency = 1}):Play()
			TweenService:Create(TabBtn.Image, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {ImageTransparency = 1}):Play()
			TweenService:Create(TabBtn.Title, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {TextTransparency = 1}):Play()
			TweenService:Create(TabBtn.Shadow, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {ImageTransparency = 1}):Play()
			TweenService:Create(TabBtn.UIStroke, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {Transparency = 1}):Play()
		end
	end

	for _, Tab in ipairs(Elements:GetChildren()) do
		if Tab.Name ~= "Template" and Tab.ClassName == "ScrollingFrame" and Tab.Name ~= "Placeholder" then
			for _, Element in ipairs(Tab:GetChildren()) do
				if Element.ClassName == "Frame" then
					if Element.Name ~= "SectionSpacing" and Element.Name ~= "Placeholder" then
						if Element:FindFirstChild('_UIPadding_') then
							TweenService:Create(Element, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {BackgroundTransparency = 1}):Play()
							TweenService:Create(Element.Title, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {TextTransparency = 1}):Play()
						else
							TweenService:Create(Element, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {BackgroundTransparency = 1}):Play()
							pcall(function()
								TweenService:Create(Element.UIStroke, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {Transparency = 1}):Play()
							end)
							TweenService:Create(Element.Title, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {TextTransparency = 1}):Play()
						end
						
						for _, Child in ipairs(Element:GetChildren()) do
							if Child.ClassName == "Frame" or Child.ClassName == "TextLabel" or Child.ClassName == "TextBox" or Child.ClassName == "ImageButton" or Child.ClassName == "ImageLabel" then
								Child.Visible = false
							end
						end
					end
				end
			end
		end
	end

	TweenService:Create(Topbar.UIStroke, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {Transparency = 0}):Play()
	TweenService:Create(Main.Shadow.Image, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {ImageTransparency = 1}):Play()
	TweenService:Create(Topbar.CornerRepair, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {BackgroundTransparency = 1}):Play()
	TweenService:Create(Topbar.Divider, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {BackgroundTransparency = 1}):Play()
	TweenService:Create(Main, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {Size = UDim2.new(0, 495, 0, 45)}):Play()
	TweenService:Create(Topbar, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {Size = UDim2.new(0, 495, 0, 45)}):Play()

	wait(0.3)

	Elements.Visible = false
	TabsList.Visible = false

	wait(0.2)
	Debounce = false
end

local KeyMainUI

function SsamachiLibrary:CreateWindow(Settings)
	Ssamachi.Enabled = false
	local Passthrough = false
	
	Topbar.Title.Text = Settings.Name
	Main.Size = UDim2.new(0, 450, 0, 260)
	Main.Visible = true
	Main.BackgroundTransparency = 1
	LoadingFrame.Title.TextTransparency = 1
	LoadingFrame.Subtitle.TextTransparency = 1
	Main.Shadow.Image.ImageTransparency = 1
	LoadingFrame.Version.TextTransparency = 1
	LoadingFrame.Title.Text = Settings.LoadingTitle or "Ssamachi Interface Suite"
	LoadingFrame.Subtitle.Text = Settings.LoadingSubtitle or "by Ssamachi"

	if Settings.LoadingTitle ~= "Ssamachi Interface Suite" then
		LoadingFrame.Version.Text = "Ssamachi UI"
	end

	Topbar.Visible = false
	Elements.Visible = false
	LoadingFrame.Visible = true

	pcall(function()
		if not Settings.ConfigurationSaving.FileName then
			Settings.ConfigurationSaving.FileName = tostring(game.PlaceId)
		end
		
		if not isfolder(SsamachiLibrary .. "/" .. "Configuration Folders") then
			-- Do nothing
		end
		
		if Settings.ConfigurationSaving.Enabled == nil then
			Settings.ConfigurationSaving.Enabled = false
		end
		
		CFileName = Settings.ConfigurationSaving.FileName
		ConfigurationFolder = Settings.ConfigurationSaving.FolderName or ConfigurationFolder
		CEnabled = Settings.ConfigurationSaving.Enabled

		if Settings.ConfigurationSaving.Enabled then
			if not isfolder(ConfigurationFolder) then
				makefolder(ConfigurationFolder)
			end	
		end
	end)

	AddDraggingFunctionality(Topbar, Main)

	if Settings.KeySystem and typeof(Settings.KeySettings.Key) == "string" then
		Settings.KeySettings.Key = {Settings.KeySettings.Key}
	end

	for _, TabButton in ipairs(TabsList:GetChildren()) do
		if TabButton.ClassName == "Frame" and TabButton.Name ~= "Placeholder" then
			TabButton.BackgroundTransparency = 1
			TabButton.Title.TextTransparency = 1
			TabButton.Shadow.ImageTransparency = 1
			TabButton.Image.ImageTransparency = 1
			TabButton.UIStroke.Transparency = 1
		end
	end

	if Settings.Discord then
		if not isfolder(SsamachiFolder .. "/Discord Invites") then
			makefolder(SsamachiFolder .. "/Discord Invites")
		end
		
		if not isfile(SsamachiFolder .. "/Discord Invites" .. "/" .. Settings.Discord.Invite .. ConfigurationExtension) then
			if Request and not (identifyexecutor and identifyexecutor():lower():match("arceus x")) then
				Request({
					Url = 'http://127.0.0.1:6463/rpc?v=1',
					Method = 'POST',
					Headers = {
						['Content-Type'] = 'application/json',
						Origin = 'https://discord.com'
					},
					Body = HttpService:JSONEncode({
						cmd = 'INVITE_BROWSER',
						nonce = HttpService:GenerateGUID(false),
						args = {code = Settings.Discord.Invite}
					})
				})
			end
			
			if Settings.Discord.RememberJoins then
				writefile(SsamachiFolder .. "/Discord Invites" .. "/" .. Settings.Discord.Invite .. ConfigurationExtension, "Ssamachi RememberJoins is true for this invite, this invite will not ask you to join again")
			end
		end
	end
	
	if Settings.KeySystem then
		if not Settings.KeySettings then
			Passthrough = true
			return
		end

		if not isfolder(SsamachiFolder .. "/Key System") then
			makefolder(SsamachiFolder .. "/Key System")
		end

		if Settings.KeySettings.GrabKeyFromSite then
			for I, Key in ipairs(Settings.KeySettings.Key) do
				local Success, Response = pcall(function()
					Settings.KeySettings.Key[I] = tostring(game:HttpGet(Key):gsub("[\n\r]", " "))
					Settings.KeySettings.Key[I] = string.gsub(Settings.KeySettings.Key[I], " ", "")
				end)
				
				if not Success then
					print("Ssamachi | " .. Key .. " Error " .. tostring(Response))
				end
			end
		end

		if not Settings.KeySettings.FileName then
			Settings.KeySettings.FileName = "No file name specified"
		end

		if isfile(SsamachiFolder .. "/Key System" .. "/" .. Settings.KeySettings.FileName .. ConfigurationExtension) then
			if readfile(SsamachiFolder .. "/Key System" .. "/" .. Settings.KeySettings.FileName .. ConfigurationExtension) == Settings.KeySettings.Key then
				Passthrough = true
			end
		end

		if not Passthrough then
			local AttemptsRemaining = math.random(2, 6)
			Ssamachi.Enabled = false
			local KeyUI = game:GetObjects("rbxassetid://11695805160")[1]
			KeyUI.Enabled = true
			
			pcall(function()
				_G.KeyUI:Destroy()
			end)
			
			_G.KeyUI = KeyUI

			ParentObject(KeyUI)

			local KeyMain = KeyUI.Main
			KeyMain.Title.Text = Settings.KeySettings.Title or Settings.Name
			KeyMain.Subtitle.Text = Settings.KeySettings.Subtitle or "Key System"
			KeyMain.NoteMessage.Text = Settings.KeySettings.Note or "No instructions"
			
			KeyMainUI = KeyMain

			KeyMain.Size = UDim2.new(0, 467, 0, 175)
			KeyMain.BackgroundTransparency = 1
			KeyMain.EShadow.ImageTransparency = 1
			KeyMain.Title.TextTransparency = 1
			KeyMain.Subtitle.TextTransparency = 1
			KeyMain.KeyNote.TextTransparency = 1
			KeyMain.Input.BackgroundTransparency = 1
			KeyMain.Input.UIStroke.Transparency = 1
			KeyMain.Input.InputBox.TextTransparency = 1
			KeyMain.NoteTitle.TextTransparency = 1
			KeyMain.NoteMessage.TextTransparency = 1
			KeyMain.Hide.ImageTransparency = 1
			KeyMain.HideP.ImageTransparency = 1
			KeyMain.Actions.Template.TextTransparency = 1

			if Settings.KeySettings.Actions then
				for _, ActionInfo in ipairs(Settings.KeySettings.Actions) do
					local Action = KeyMain.Actions.Template:Clone()
					Action.Text = ActionInfo.Text
					Action.MouseButton1Down:Connect(ActionInfo.OnPress)
					Action.MouseEnter:Connect(function()
						TweenService:Create(Action, TweenInfo.new(.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextColor3 = Color3.fromRGB(185, 185, 185)}):Play()
					end)
					Action.MouseLeave:Connect(function()
						TweenService:Create(Action, TweenInfo.new(.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextColor3 = Color3.fromRGB(105, 105, 105)}):Play()
					end)
					Action.Parent = KeyMain.Actions
					Delay(.2, function()
						Action.Visible = true
						TweenService:Create(Action, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {TextTransparency = 0}):Play()
					end)
				end
			end

			TweenService:Create(KeyMain, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {BackgroundTransparency = 0}):Play()
			TweenService:Create(KeyMain, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {Size = UDim2.new(0, 500, 0, 187)}):Play()
			TweenService:Create(KeyMain.EShadow, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {ImageTransparency = 0.5}):Play()
			
			wait(0.05)
			
			TweenService:Create(KeyMain.Title, TweenInfo.new(0.4, Enum.EasingStyle.Quint), {TextTransparency = 0}):Play()
			TweenService:Create(KeyMain.Subtitle, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {TextTransparency = 0}):Play()
			
			wait(0.05)
			
			TweenService:Create(KeyMain.KeyNote, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {TextTransparency = 0}):Play()
			TweenService:Create(KeyMain.Input, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {BackgroundTransparency = 0}):Play()
			TweenService:Create(KeyMain.Input.UIStroke, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {Transparency = 0}):Play()
			TweenService:Create(KeyMain.Input.HidenInput, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {TextTransparency = 0}):Play()
			
			wait(0.05)
			
			TweenService:Create(KeyMain.NoteTitle, TweenInfo.new(0.4, Enum.EasingStyle.Quint), {TextTransparency = 0}):Play()
			TweenService:Create(KeyMain.NoteMessage, TweenInfo.new(0.4, Enum.EasingStyle.Quint), {TextTransparency = 0}):Play()
			
			wait(0.15)
			
			TweenService:Create(KeyMain.Hide, TweenInfo.new(0.4, Enum.EasingStyle.Quint), {ImageTransparency = 0.3}):Play()
			TweenService:Create(KeyMain.HideP, TweenInfo.new(0.4, Enum.EasingStyle.Quint), {ImageTransparency = 0.3}):Play()
			
			KeyUI.Main.Input.InputBox:GetPropertyChangedSignal('Text'):Connect(function()
				KeyUI.Main.Input.HidenInput.Text = string.rep('•', #KeyUI.Main.Input.InputBox.Text)
			end)
			
			KeyUI.Main.Input.InputBox.FocusLost:Connect(function(EnterPressed)
				if not EnterPressed then
					return
				end
				
				if #KeyUI.Main.Input.InputBox.Text == 0 then
					return
				end
				
				local KeyFound = false
				local FoundKey = ''
				
				for _, MKey in ipairs(Settings.KeySettings.Key) do
					if KeyMain.Input.InputBox.Text == MKey then
						KeyFound = true
						FoundKey = MKey
					end
				end
				
				if KeyFound then
					for _, Action in ipairs(KeyMain.Actions:GetChildren()) do
						if Action:IsA('TextButton') then
							TweenService:Create(Action, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {TextTransparency = 1}):Play()
						end
					end
					
					TweenService:Create(KeyMain, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {BackgroundTransparency = 1}):Play()
					TweenService:Create(KeyMain, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {Size = UDim2.new(0, 467, 0, 175)}):Play()
					TweenService:Create(KeyMain.EShadow, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {ImageTransparency = 1}):Play()
					TweenService:Create(KeyMain.Title, TweenInfo.new(0.4, Enum.EasingStyle.Quint), {TextTransparency = 1}):Play()
					TweenService:Create(KeyMain.Subtitle, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {TextTransparency = 1}):Play()
					TweenService:Create(KeyMain.KeyNote, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {TextTransparency = 1}):Play()
					TweenService:Create(KeyMain.Input, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {BackgroundTransparency = 1}):Play()
					TweenService:Create(KeyMain.Input.UIStroke, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {Transparency = 1}):Play()
					TweenService:Create(KeyMain.Input.InputBox, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {TextTransparency = 1}):Play()
					TweenService:Create(KeyMain.Input.HidenInput, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {TextTransparency = 1}):Play()
					TweenService:Create(KeyMain.NoteTitle, TweenInfo.new(0.4, Enum.EasingStyle.Quint), {TextTransparency = 1}):Play()
					TweenService:Create(KeyMain.NoteMessage, TweenInfo.new(0.4, Enum.EasingStyle.Quint), {TextTransparency = 1}):Play()
					TweenService:Create(KeyMain.Hide, TweenInfo.new(0.4, Enum.EasingStyle.Quint), {ImageTransparency = 1}):Play()
					TweenService:Create(KeyMain.HideP, TweenInfo.new(0.4, Enum.EasingStyle.Quint), {ImageTransparency = 1}):Play()
					
					Delay(.4, function()
						KeyMain.Hide.Visible = false
						KeyUI:Destroy()
					end)
					
					wait(0.51)
					Passthrough = true
					
					if Settings.KeySettings.SaveKey then
						if writefile then
							writefile(SsamachiFolder .. "/Key System" .. "/" .. Settings.KeySettings.FileName .. ConfigurationExtension, Settings.KeySettings.Key)
						end
					end
				else
					if AttemptsRemaining == 0 then
						TweenService:Create(KeyMain, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {BackgroundTransparency = 1}):Play()
						TweenService:Create(KeyMain, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {Size = UDim2.new(0, 467, 0, 175)}):Play()
						TweenService:Create(KeyMain.Shadow.Image, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {ImageTransparency = 1}):Play()
						TweenService:Create(KeyMain.Title, TweenInfo.new(0.4, Enum.EasingStyle.Quint), {TextTransparency = 1}):Play()
						TweenService:Create(KeyMain.Subtitle, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {TextTransparency = 1}):Play()
						TweenService:Create(KeyMain.KeyNote, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {TextTransparency = 1}):Play()
						TweenService:Create(KeyMain.Input, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {BackgroundTransparency = 1}):Play()
						TweenService:Create(KeyMain.Input.UIStroke, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {Transparency = 1}):Play()
						TweenService:Create(KeyMain.Input.InputBox, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {TextTransparency = 1}):Play()
						TweenService:Create(KeyMain.Input.HidenInput, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {TextTransparency = 1}):Play()
						TweenService:Create(KeyMain.NoteTitle, TweenInfo.new(0.4, Enum.EasingStyle.Quint), {TextTransparency = 1}):Play()
						TweenService:Create(KeyMain.NoteMessage, TweenInfo.new(0.4, Enum.EasingStyle.Quint), {TextTransparency = 1}):Play()
						TweenService:Create(KeyMain.Hide, TweenInfo.new(0.4, Enum.EasingStyle.Quint), {ImageTransparency = 1}):Play()
						TweenService:Create(KeyMain.HideP, TweenInfo.new(0.4, Enum.EasingStyle.Quint), {ImageTransparency = 1}):Play()
						
						wait(0.45)
						game.Players.LocalPlayer:Kick("No Attempts Remaining")
						game:Shutdown()
					end
					
					KeyMain.Input.InputBox.Text = ""
					AttemptsRemaining = AttemptsRemaining - 1
					
					TweenService:Create(KeyMain, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {Size = UDim2.new(0, 467, 0, 175)}):Play()
					TweenService:Create(KeyMain, TweenInfo.new(0.4, Enum.EasingStyle.Elastic), {Position = UDim2.new(0.495, 0, 0.5, 0)}):Play()
					
					wait(0.1)
					
					TweenService:Create(KeyMain, TweenInfo.new(0.4, Enum.EasingStyle.Elastic), {Position = UDim2.new(0.505, 0, 0.5, 0)}):Play()
					
					wait(0.1)
					
					TweenService:Create(KeyMain, TweenInfo.new(0.4, Enum.EasingStyle.Quint), {Position = UDim2.new(0.5, 0, 0.5, 0)}):Play()
					TweenService:Create(KeyMain, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {Size = UDim2.new(0, 500, 0, 187)}):Play()
				end
			end)
			
			local Hidden = true
			
			KeyMain.HideP.MouseButton1Click:Connect(function()
				if Hidden then
					TweenService:Create(KeyMain.Input.HidenInput, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {TextTransparency = 1}):Play()
					TweenService:Create(KeyMain.Input.InputBox, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {TextTransparency = 0}):Play()
					Hidden = false
				else
					TweenService:Create(KeyMain.Input.HidenInput, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {TextTransparency = 0}):Play()
					TweenService:Create(KeyMain.Input.InputBox, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {TextTransparency = 1}):Play()
					Hidden = true
				end
			end)

			KeyMain.Hide.MouseButton1Click:Connect(function()
				TweenService:Create(KeyMain, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {BackgroundTransparency = 1}):Play()
				TweenService:Create(KeyMain, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {Size = UDim2.new(0, 467, 0, 175)}):Play()
				TweenService:Create(KeyMain.EShadow, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {ImageTransparency = 1}):Play()
				TweenService:Create(KeyMain.Title, TweenInfo.new(0.4, Enum.EasingStyle.Quint), {TextTransparency = 1}):Play()
				TweenService:Create(KeyMain.Subtitle, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {TextTransparency = 1}):Play()
				TweenService:Create(KeyMain.KeyNote, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {TextTransparency = 1}):Play()
				TweenService:Create(KeyMain.Input, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {BackgroundTransparency = 1}):Play()
				TweenService:Create(KeyMain.Input.UIStroke, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {Transparency = 1}):Play()
				TweenService:Create(KeyMain.Input.InputBox, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {TextTransparency = 1}):Play()
				TweenService:Create(KeyMain.NoteTitle, TweenInfo.new(0.4, Enum.EasingStyle.Quint), {TextTransparency = 1}):Play()
				TweenService:Create(KeyMain.Input.HidenInput, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {TextTransparency = 1}):Play()
				TweenService:Create(KeyMain.NoteMessage, TweenInfo.new(0.4, Enum.EasingStyle.Quint), {TextTransparency = 1}):Play()
				TweenService:Create(KeyMain.Hide, TweenInfo.new(0.4, Enum.EasingStyle.Quint), {ImageTransparency = 1}):Play()
				TweenService:Create(KeyMain.HideP, TweenInfo.new(0.4, Enum.EasingStyle.Quint), {ImageTransparency = 1}):Play()
				
				wait(0.51)
				
				SsamachiLibrary:Destroy()
				KeyUI:Destroy()
			end)
		else
			Passthrough = true
		end
	end
	
	if Settings.KeySystem then
		repeat wait() until Passthrough
	end
	
	Ssamachi.Enabled = true
	
	for _, TabBtn in pairs(SideList:GetChildren()) do
		if TabBtn.ClassName == "Frame" and TabBtn.Name ~= "Placeholder" then
			TweenService:Create(TabBtn.Title, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {TextTransparency = 1}):Play()
			TweenService:Create(TabBtn.Image, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {ImageTransparency = 1}):Play()
		end
	end
	
	TweenService:Create(Main.SideTabList, TweenInfo.new(0, Enum.EasingStyle.Quint), {BackgroundTransparency = 1, Size = UDim2.new(0, 150, 0, 390), Position = UDim2.new(0, 10, 0.5, 22)}):Play()
	TweenService:Create(Main.SideTabList.UIStroke, TweenInfo.new(0, Enum.EasingStyle.Quint), {Transparency = 1}):Play()
	TweenService:Create(Main.SideTabList.RDMT, TweenInfo.new(0, Enum.EasingStyle.Quint), {TextTransparency = 1}):Play()

	TweenService:Create(InfoPrompt, TweenInfo.new(.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
		Size = UDim2.fromOffset(212, 254),
		BackgroundTransparency = 1
	}):Play()
	
	TweenService:Create(InfoPrompt.ImageLabel, TweenInfo.new(.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
		ImageTransparency = 1
	}):Play()
	
	TweenService:Create(InfoPrompt.Description, TweenInfo.new(.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
		TextTransparency = 1
	}):Play()
	
	TweenService:Create(InfoPrompt.Status, TweenInfo.new(.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
		TextTransparency = 1
	}):Play()
	
	TweenService:Create(InfoPrompt.Title, TweenInfo.new(.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
		TextTransparency = 1
	}):Play()

	TopList.Template.Visible = false
	SideList.SideTemplate.Visible = false
	Notifications.Template.Visible = false
	Notifications.Visible = true
	
	wait(0.5)
	
	TweenService:Create(Main, TweenInfo.new(0.7, Enum.EasingStyle.Quint), {BackgroundTransparency = 0}):Play()
	TweenService:Create(Main.Shadow.Image, TweenInfo.new(0.7, Enum.EasingStyle.Quint), {ImageTransparency = 0.55}):Play()
	
	wait(0.1)
	
	TweenService:Create(LoadingFrame.Title, TweenInfo.new(0.7, Enum.EasingStyle.Quint), {TextTransparency = 0}):Play()
	
	wait(0.05)
	
	TweenService:Create(LoadingFrame.Subtitle, TweenInfo.new(0.7, Enum.EasingStyle.Quint), {TextTransparency = 0}):Play()
	
	wait(0.05)
	
	TweenService:Create(LoadingFrame.Version, TweenInfo.new(0.7, Enum.EasingStyle.Quint), {TextTransparency = 0}):Play()

	Elements.Template.LayoutOrder = 100000
	Elements.Template.Visible = false

	Elements.UIPageLayout.FillDirection = Enum.FillDirection.Horizontal

	local FirstTab = false
	SsamachiQuality.Window = {Tabs = {}}
	local Window = SsamachiQuality.Window
	
	function Window:CreateTab(Name, Image)
		Window.Tabs[Name] = {Elements = {}}
		local Tab = Window.Tabs[Name]
		local SDone = false
		local TopTabButton, SideTabButton = TopList.Template:Clone(), SideList.SideTemplate:Clone()

		SideTabButton.Parent = SideList
		TopTabButton.Parent = TopList

		TopTabButton.Name = Name
		SideTabButton.Name = Name

		TopTabButton.Title.Text = Name
		SideTabButton.Title.Text = Name
		
		SideTabButton.Title.TextWrapped = false
		TopTabButton.Title.TextWrapped = false 

		TopTabButton.Size = UDim2.new(0, TopTabButton.Title.TextBounds.X + 30, 0, 30)

		if Image then
			TopTabButton.Image.Image = "rbxassetid://" .. Image
			SideTabButton.Image.Image = "rbxassetid://" .. Image

			TopTabButton.Title.AnchorPoint = Vector2.new(0, 0.5)
			TopTabButton.Title.Position = UDim2.new(0, 37, 0.5, 0)
			TopTabButton.Image.Visible = true
			TopTabButton.Title.TextXAlignment = Enum.TextXAlignment.Left
			TopTabButton.Size = UDim2.new(0, TopTabButton.Title.TextBounds.X + 46, 0, 30)
		end

		TopTabButton.BackgroundTransparency = 1
		TopTabButton.Title.TextTransparency = 1
		TopTabButton.Shadow.ImageTransparency = 1
		TopTabButton.Image.ImageTransparency = 1
		TopTabButton.UIStroke.Transparency = 1

		SideTabButton.BackgroundTransparency = 1
		SideTabButton.Title.TextTransparency = 1
		SideTabButton.Shadow.ImageTransparency = 1
		SideTabButton.Image.ImageTransparency = 1
		SideTabButton.UIStroke.Transparency = 1

		TopTabButton.Visible = true
		SideTabButton.Visible = true

		local TabPage = Elements.Template:Clone()
		TabPage.Name = Name
		TabPage.Visible = true

		TabPage.LayoutOrder = #Elements:GetChildren()

		for _, TemplateElement in ipairs(TabPage:GetChildren()) do
			if TemplateElement.ClassName == "Frame" and TemplateElement.Name ~= "Placeholder" then
				TemplateElement:Destroy()
			end
		end

		TabPage.Parent = Elements
		
		if not FirstTab then
			Elements.UIPageLayout.Animated = false
			Elements.UIPageLayout:JumpTo(TabPage)
			Elements.UIPageLayout.Animated = true
		end

		if SelectedTheme ~= SsamachiLibrary.Theme.Default then
			TopTabButton.Shadow.Visible = false
		end
		
		TopTabButton.UIStroke.Color = SelectedTheme.TabStroke
		
		wait(0.1)
		
		if FirstTab then
			TopTabButton.BackgroundColor3 = SelectedTheme.TabBackground
			TopTabButton.Image.ImageColor3 = SelectedTheme.TabTextColor
			TopTabButton.Title.TextColor3 = SelectedTheme.TabTextColor
			
			TweenService:Create(TopTabButton, TweenInfo.new(0.7, Enum.EasingStyle.Quint), {BackgroundTransparency = 0.7}):Play()
			TweenService:Create(TopTabButton.Title, TweenInfo.new(0.7, Enum.EasingStyle.Quint), {TextTransparency = 0.2}):Play()
			TweenService:Create(TopTabButton.Image, TweenInfo.new(0.7, Enum.EasingStyle.Quint), {ImageTransparency = 0.2}):Play()
			TweenService:Create(TopTabButton.UIStroke, TweenInfo.new(0.7, Enum.EasingStyle.Quint), {Transparency = 0}):Play()
			TweenService:Create(TopTabButton.Shadow, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {ImageTransparency = 0.7}):Play()

			TweenService:Create(SideTabButton.Image, TweenInfo.new(0.7, Enum.EasingStyle.Quint), {ImageTransparency = 0, ImageColor3 = Color3.fromRGB(205, 205, 205)}):Play()
			TweenService:Create(SideTabButton.Title, TweenInfo.new(0.7, Enum.EasingStyle.Quint), {TextTransparency = .2, TextColor3 = Color3.fromRGB(205, 205, 205)}):Play()	
		else
			FirstTab = Name

			TopTabButton.BackgroundColor3 = SelectedTheme.TabBackgroundSelected
			TopTabButton.Image.ImageColor3 = SelectedTheme.SelectedTabTextColor
			TopTabButton.Title.TextColor3 = SelectedTheme.SelectedTabTextColor
			
			TweenService:Create(TopTabButton.Shadow, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {ImageTransparency = 0.9}):Play()
			TweenService:Create(TopTabButton.Image, TweenInfo.new(0.7, Enum.EasingStyle.Quint), {ImageTransparency = 0}):Play()
			TweenService:Create(TopTabButton, TweenInfo.new(0.7, Enum.EasingStyle.Quint), {BackgroundTransparency = 0}):Play()
			TweenService:Create(TopTabButton.Title, TweenInfo.new(0.7, Enum.EasingStyle.Quint), {TextTransparency = 0}):Play()

			SideTabButton.Image.ImageColor3 = Color3.fromRGB(255, 255, 255)
			SideTabButton.Title.TextColor3 = Color3.fromRGB(255, 255, 255)
			
			TweenService:Create(SideTabButton.Image, TweenInfo.new(0.7, Enum.EasingStyle.Quint), {ImageTransparency = 0}):Play()
			TweenService:Create(SideTabButton.Title, TweenInfo.new(0.7, Enum.EasingStyle.Quint), {TextTransparency = 0}):Play()
		end

		local function Pick()
			if Minimised then
				return
			end
			
			TweenService:Create(TopTabButton, TweenInfo.new(0.7, Enum.EasingStyle.Quint), {BackgroundTransparency = 0}):Play()
			TweenService:Create(TopTabButton.UIStroke, TweenInfo.new(0.7, Enum.EasingStyle.Quint), {Transparency = 1}):Play()
			TweenService:Create(TopTabButton.Title, TweenInfo.new(0.7, Enum.EasingStyle.Quint), {TextTransparency = 0}):Play()
			TweenService:Create(TopTabButton.Image, TweenInfo.new(0.7, Enum.EasingStyle.Quint), {ImageTransparency = 0}):Play()
			TweenService:Create(TopTabButton, TweenInfo.new(0.7, Enum.EasingStyle.Quint), {BackgroundColor3 = SelectedTheme.TabBackgroundSelected}):Play()
			TweenService:Create(TopTabButton.Title, TweenInfo.new(0.7, Enum.EasingStyle.Quint), {TextColor3 = SelectedTheme.SelectedTabTextColor}):Play()
			TweenService:Create(TopTabButton.Image, TweenInfo.new(0.7, Enum.EasingStyle.Quint), {ImageColor3 = SelectedTheme.SelectedTabTextColor}):Play()
			TweenService:Create(TopTabButton.Shadow, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {ImageTransparency = 0.9}):Play()

			TweenService:Create(SideTabButton.Image, TweenInfo.new(0.7, Enum.EasingStyle.Quint), {ImageTransparency = 0, ImageColor3 = Color3.fromRGB(255, 255, 255)}):Play()
			TweenService:Create(SideTabButton.Title, TweenInfo.new(0.7, Enum.EasingStyle.Quint), {TextTransparency = 0, TextColor3 = Color3.fromRGB(255, 255, 255)}):Play()
			
			Elements.UIPageLayout:JumpTo(TabPage)
			
			for _, OtherTabButton in ipairs(TopList:GetChildren()) do
				Spawn(function()
					if OtherTabButton.Name ~= "Template" and OtherTabButton.ClassName == "Frame" and OtherTabButton ~= TopTabButton and OtherTabButton.Name ~= "Placeholder" then
						TweenService:Create(OtherTabButton, TweenInfo.new(0.7, Enum.EasingStyle.Quint), {BackgroundColor3 = SelectedTheme.TabBackground, BackgroundTransparency = .7}):Play()
						TweenService:Create(OtherTabButton.Image, TweenInfo.new(0.7, Enum.EasingStyle.Quint), {ImageColor3 = Color3.fromRGB(240, 240, 240)}):Play()
						TweenService:Create(OtherTabButton.UIStroke, TweenInfo.new(0.7, Enum.EasingStyle.Quint), {Transparency = 0, Color = Color3.fromRGB(85, 85, 85)}):Play()
						TweenService:Create(OtherTabButton.Shadow, TweenInfo.new(0.7, Enum.EasingStyle.Quint), {ImageTransparency = .85, ImageColor3 = Color3.fromRGB(20, 20, 20)}):Play()
						TweenService:Create(OtherTabButton.Title, TweenInfo.new(0.7, Enum.EasingStyle.Quint), {TextColor3 = Color3.fromRGB(240, 240, 240), TextTransparency = .2}):Play()
					end
				end)
			end
			
			for _, OtherTabButton in ipairs(SideList:GetChildren()) do
				Spawn(function()
					if OtherTabButton.Name ~= "Template" and OtherTabButton.ClassName == "Frame" and OtherTabButton ~= SideTabButton and OtherTabButton.Name ~= "Placeholder" then
						TweenService:Create(OtherTabButton.Image, TweenInfo.new(0.7, Enum.EasingStyle.Quint), {ImageTransparency = 0, ImageColor3 = Color3.fromRGB(205, 205, 205)}):Play()
						TweenService:Create(OtherTabButton.Title, TweenInfo.new(0.7, Enum.EasingStyle.Quint), {TextTransparency = .2, TextColor3 = Color3.fromRGB(205, 205, 205)}):Play()	
					end
				end)
			end
		end

		TopTabButton.Interact.MouseButton1Click:Connect(Pick)
		SideTabButton.Interact.MouseButton1Click:Connect(Pick)

		function Tab:CreateButton(ButtonSettings)
			local ButtonValue = {Locked = false}

			local Button = Elements.Template.Button:Clone()
			ButtonValue.Button = Button
			Tab.Elements[Button.Name] = {
				type = 'button',
				section = ButtonSettings.SectionParent,
				element = Button
			}
			AddInfos(Button, ButtonSettings.Info, 'button')

			Button.Name = ButtonSettings.Name
			Button.Title.Text = ButtonSettings.Name
			Button.ElementIndicator.Text = ButtonSettings.Interact or 'button'
			Button.Visible = true

			Button.BackgroundTransparency = 1
			Button.UIStroke.Transparency = 1
			Button.Title.TextTransparency = 1
			
			if ButtonSettings.SectionParent then
				Button.Parent = ButtonSettings.SectionParent.Holder
			else
				Button.Parent = TabPage
			end
			
			TweenService:Create(Button, TweenInfo.new(0.7, Enum.EasingStyle.Quint), {BackgroundTransparency = 0}):Play()
			TweenService:Create(Button.UIStroke, TweenInfo.new(0.7, Enum.EasingStyle.Quint), {Transparency = 0}):Play()
			TweenService:Create(Button.Title, TweenInfo.new(0.7, Enum.EasingStyle.Quint), {TextTransparency = 0}):Play()	

			Button.Interact.MouseButton1Click:Connect(function()
				if ButtonValue.Locked then
					return
				end
				
				local Success, Response = pcall(ButtonSettings.Callback)
				
				if not Success then
					TweenService:Create(Button, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {BackgroundColor3 = Color3.fromRGB(85, 0, 0)}):Play()
					TweenService:Create(Button.ElementIndicator, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {TextTransparency = 1}):Play()
					TweenService:Create(Button.UIStroke, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {Transparency = 1}):Play()
					Button.Title.Text = "Callback Error"
					print("Ssamachi | " .. ButtonSettings.Name .. " Callback Error " .. tostring(Response))
					
					wait(0.5)
					
					Button.Title.Text = ButtonSettings.Name
					TweenService:Create(Button, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {BackgroundColor3 = SelectedTheme.ElementBackground}):Play()
					TweenService:Create(Button.UIStroke, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {Transparency = 0}):Play()
					TweenService:Create(Button.ElementIndicator, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {TextTransparency = 0.9}):Play()
				else
					SaveConfiguration()
					TweenService:Create(Button, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {BackgroundColor3 = SelectedTheme.ElementBackgroundHover}):Play()
					TweenService:Create(Button.ElementIndicator, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {TextTransparency = 1}):Play()
					TweenService:Create(Button.UIStroke, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {Transparency = 1}):Play()
					
					wait(0.2)
					
					TweenService:Create(Button, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {BackgroundColor3 = SelectedTheme.ElementBackground}):Play()
					TweenService:Create(Button.UIStroke, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {Transparency = 0}):Play()
					TweenService:Create(Button.ElementIndicator, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {TextTransparency = 0.9}):Play()
				end
			end)

			Button.MouseEnter:Connect(function()
				TweenService:Create(Button, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {BackgroundColor3 = SelectedTheme.ElementBackgroundHover}):Play()
				TweenService:Create(Button.ElementIndicator, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {TextTransparency = 0.7}):Play()
			end)

			Button.MouseLeave:Connect(function()
				TweenService:Create(Button, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {BackgroundColor3 = SelectedTheme.ElementBackground}):Play()
				TweenService:Create(Button.ElementIndicator, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {TextTransparency = 0.9}):Play()
			end)

			function ButtonValue:Set(NewButton, Interaction)
				Button.Title.Text = NewButton or Button.Title.Text
				Button.Name = NewButton or Button.Name
				Button.ElementIndicator.Text = Interaction or Button.ElementIndicator.Text
			end
			
			function ButtonValue:Destroy()
				Button:Destroy()
			end
			
			function ButtonValue:Lock(Reason)
				if ButtonValue.Locked then
					return
				end
				
				ButtonValue.Locked = true
				Button.Lock.Reason.Text = Reason or 'Locked'
				TweenService:Create(Button.Lock, TweenInfo.new(0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundTransparency = 0}):Play()
				TweenService:Create(Button.Lock.Reason, TweenInfo.new(0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {TextTransparency = 0}):Play()
				
				wait(0.2)
				
				if not ButtonValue.Locked then
					return
				end
				
				TweenService:Create(Button.Lock.Reason.Icon, TweenInfo.new(0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {ImageTransparency = 0}):Play()
			end
			
			function ButtonValue:Unlock()
				if not ButtonValue.Locked then
					return
				end
				
				ButtonValue.Locked = false
				
				wait(0.2)
				
				TweenService:Create(Button.Lock.Reason.Icon, TweenInfo.new(0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {ImageTransparency = 1}):Play()
				
				if ButtonValue.Locked then
					return
				end
				
				TweenService:Create(Button.Lock, TweenInfo.new(0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundTransparency = 1}):Play()
				TweenService:Create(Button.Lock.Reason, TweenInfo.new(0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {TextTransparency = 1}):Play()
			end
			
			function ButtonValue:Visible(Bool)
				Button.Visible = Bool
			end

			return ButtonValue
		end

		function Tab:CreateSection(SectionName, Display)
			local SectionValue = {
				Holder = Ssamachi.Holding,
				Open = true
			}
			local Debounce = false
			local Section = Elements.Template.SectionTitle:Clone()
			SectionValue.Holder = Section.Holder
			Section.Title.Text = SectionName
			Section.Visible = true
			Section.Parent = TabPage

			Tab.Elements[SectionName] = {
				type = 'section',
				display = Display,
				sectionholder = Section.Holder,
				element = Section
			}

			Section.Title.TextTransparency = 1
			TweenService:Create(Section.Title, TweenInfo.new(0.7, Enum.EasingStyle.Quint), {TextTransparency = 0}):Play()

			function SectionValue:Set(NewSection)
				Section.Title.Text = NewSection
			end
			
			if Display then
				Section._UIPadding_:Destroy()
				Section.Holder.Visible = false
				Section.BackgroundTransparency = 1
				SectionValue.Holder.Parent = Ssamachi.Holding
				Section.Title.ImageButton.Visible = false
			end
			
			Section.Title.ImageButton.MouseButton1Down:Connect(function()
				if Debounce then
					return
				end
				
				if SectionValue.Open then
					Debounce = true
					
					TweenService:Create(Section._UIPadding_, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {PaddingBottom = UDim.new(0, 0)}):Play()
					
					for _, Element in ipairs(Section.Holder:GetChildren()) do
						if Element.ClassName == "Frame" then
							if Element.Name ~= "SectionSpacing" and Element.Name ~= "Placeholder" and Element.Name ~= 'Topholder' then
								if Element.Name == "SectionTitle" then
									TweenService:Create(Element.Title, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {TextTransparency = 1}):Play()
								else
									TweenService:Create(Element, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {BackgroundTransparency = 1}):Play()
									TweenService:Create(Element.UIStroke, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {Transparency = 1}):Play()
									TweenService:Create(Element.Title, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {TextTransparency = 1}):Play()
								end
								
								for _, Child in ipairs(Element:GetChildren()) do
									if Child.ClassName == "Frame" then
										Child.Visible = false
									end
								end
							end
							
							Element.Visible = false
						end
					end
					
					TweenService:Create(Section.Title.ImageButton, TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Rotation = 180}):Play()
					SectionValue.Open = false
					Debounce = false
				else
					Debounce = true
					
					TweenService:Create(Section._UIPadding_, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {PaddingBottom = UDim.new(0, 8)}):Play()
					
					for _, Element in ipairs(Section.Holder:GetChildren()) do
						if Element.ClassName == "Frame" then
							if Element.Name ~= "SectionSpacing" and Element.Name ~= "Placeholder" and Element.Name ~= 'Topholder' and not Element:FindFirstChild('ColorPickerIs') then
								if Element.Name == "SectionTitle" then
									TweenService:Create(Element.Title, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {TextTransparency = 0}):Play()
								else
									TweenService:Create(Element, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {BackgroundTransparency = 0}):Play()
									TweenService:Create(Element.UIStroke, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {Transparency = 0}):Play()
									TweenService:Create(Element.Title, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {TextTransparency = 0}):Play()
								end
								
								for _, Child in ipairs(Element:GetChildren()) do
									if (Child.ClassName == "Frame" or Child.ClassName == "TextLabel" or Child.ClassName == "TextBox" or Child.ClassName == "ImageButton" or Child.ClassName == "ImageLabel") then
										Child.Visible = true
									end
								end
							elseif Element:FindFirstChild('ColorPickerIs') then
								TweenService:Create(Element, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {BackgroundTransparency = 0}):Play()
								TweenService:Create(Element.UIStroke, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {Transparency = 0}):Play()
								TweenService:Create(Element.Title, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {TextTransparency = 0}):Play()
								
								if Element.ColorPickerIs.Value then
									Element.ColorSlider.Visible = true
									Element.HexInput.Visible = true
									Element.RGB.Visible = true
								end
								
								Element.CPBackground.Visible = true
								Element.Lock.Visible = true
								Element.Interact.Visible = true
								Element.Title.Visible = true
							end
							
							Element.Visible = true
						end
					end
					
					TweenService:Create(Section.Title.ImageButton, TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Rotation = 0}):Play()
					SectionValue.Open = true
					
					wait(.3)
					Debounce = false
				end
			end)
			
			SDone = true
			
			function SectionValue:Lock(Reason)
				-- Do nothing
			end
			
			function SectionValue:Unlock(Reason)
				-- Do nothing
			end

			return SectionValue
		end

		function Tab:CreateSpacing(SectionParent, Size)
			local Spacing = Elements.Template.SectionSpacing:Clone()
			Spacing.Visible = true
			Spacing.Parent = TabPage

			Spacing.Size = UDim2.fromOffset(475, Size or 6)

			if SectionParent then
				Spacing.Parent = SectionParent.Holder
			else
				Spacing.Parent = TabPage
			end
		end

		function Tab:CreateLabel(LabelText, SectionParent)
			local LabelValue = {}

			local Label = Elements.Template.Label:Clone()
			Label.Title.Text = LabelText
			Label.Visible = true
			Tab.Elements[LabelText] = {
				type = 'label',
				section = SectionParent,
				element = Label
			}
			
			if SectionParent then
				Label.Parent = SectionParent.Holder
			else
				Label.Parent = TabPage
			end

			Label.BackgroundTransparency = 1
			Label.UIStroke.Transparency = 1
			Label.Title.TextTransparency = 1

			Label.BackgroundColor3 = SelectedTheme.SecondaryElementBackground
			Label.UIStroke.Color = SelectedTheme.SecondaryElementStroke

			TweenService:Create(Label, TweenInfo.new(0.7, Enum.EasingStyle.Quint), {BackgroundTransparency = 0}):Play()
			TweenService:Create(Label.UIStroke, TweenInfo.new(0.7, Enum.EasingStyle.Quint), {Transparency = 0}):Play()
			TweenService:Create(Label.Title, TweenInfo.new(0.7, Enum.EasingStyle.Quint), {TextTransparency = 0}):Play()	

			function LabelValue:Set(NewLabel)
				Label.Title.Text = NewLabel
			end

			return LabelValue
		end

		function Tab:CreateParagraph(ParagraphSettings, SectionParent)
			local ParagraphValue = {}

			local Paragraph = Elements.Template.Paragraph:Clone()
			Paragraph.Title.Text = ParagraphSettings.Title
			Paragraph.Content.Text = ParagraphSettings.Content
			Paragraph.Visible = true

			Tab.Elements[ParagraphSettings.Title] = {
				type = 'paragraph',
				section = ParagraphSettings.SectionParent,
				element = Paragraph
			}

			if SectionParent or ParagraphSettings.SectionParent.Holder then
				Paragraph.Parent = SectionParent.Holder or ParagraphSettings.SectionParent.Holder
			else
				Paragraph.Parent = TabPage
			end

			Paragraph.Content.Size = UDim2.new(0, 438, 0, Paragraph.Content.TextBounds.Y)
			Paragraph.Size = UDim2.new(0, 465, 0, Paragraph.Content.TextBounds.Y + 40)

			Paragraph.BackgroundTransparency = 1
			Paragraph.UIStroke.Transparency = 1
			Paragraph.Title.TextTransparency = 1
			Paragraph.Content.TextTransparency = 1

			Paragraph.BackgroundColor3 = SelectedTheme.SecondaryElementBackground
			Paragraph.UIStroke.Color = SelectedTheme.SecondaryElementStroke

			TweenService:Create(Paragraph, TweenInfo.new(0.7, Enum.EasingStyle.Quint), {BackgroundTransparency = 0}):Play()
			TweenService:Create(Paragraph.UIStroke, TweenInfo.new(0.7, Enum.EasingStyle.Quint), {Transparency = 0}):Play()
			TweenService:Create(Paragraph.Title, TweenInfo.new(0.7, Enum.EasingStyle.Quint), {TextTransparency = 0}):Play()	
			TweenService:Create(Paragraph.Content, TweenInfo.new(0.7, Enum.EasingStyle.Quint), {TextTransparency = 0}):Play()	

			function ParagraphValue:Set(NewParagraphSettings)
				Paragraph.Title.Text = NewParagraphSettings.Title
				Paragraph.Content.Text = NewParagraphSettings.Content
			end

			return ParagraphValue
		end

		function Tab:CreateInput(InputSettings)
			local Input = Elements.Template.Input:Clone()
			Input.Name = InputSettings.Name
			Input.Title.Text = InputSettings.Name
			Input.Visible = true
			InputSettings.Locked = false
			
			Tab.Elements[InputSettings.Name] = {
				type = 'input',
				section = InputSettings.SectionParent,
				element = Input
			}
			
			if InputSettings.SectionParent then
				Input.Parent = InputSettings.SectionParent.Holder
			else
				Input.Parent = TabPage
			end
			
			AddInfos(Input, InputSettings.Info, 'input')
			
			Input.BackgroundTransparency = 1
			Input.UIStroke.Transparency = 1
			Input.Title.TextTransparency = 1

			Input.InputFrame.BackgroundColor3 = SelectedTheme.InputBackground
			Input.InputFrame.UIStroke.Color = SelectedTheme.InputStroke

			TweenService:Create(Input, TweenInfo.new(0.7, Enum.EasingStyle.Quint), {BackgroundTransparency = 0}):Play()
			TweenService:Create(Input.UIStroke, TweenInfo.new(0.7, Enum.EasingStyle.Quint), {Transparency = 0}):Play()
			TweenService:Create(Input.Title, TweenInfo.new(0.7, Enum.EasingStyle.Quint), {TextTransparency = 0}):Play()	

			Input.InputFrame.InputBox.PlaceholderText = InputSettings.PlaceholderText
			Input.InputFrame.Size = UDim2.new(0, Input.InputFrame.InputBox.TextBounds.X + 24, 0, 30)
			
			Input.InputFrame.InputBox:GetPropertyChangedSignal('Text'):Connect(function()
				local TextBox = Input.InputFrame.InputBox
				local TextSize = game:GetService("TextService"):GetTextSize(TextBox.Text, TextBox.TextSize, TextBox.Font, TextBox.AbsoluteSize)
				TweenService:Create(Input.InputFrame, TweenInfo.new(0.55, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Size = UDim2.new(0, TextSize.X + 24, 0, 30)}):Play()
				
				if Input.InputFrame.InputBox.Text == '' then
					return
				end
				
				if InputSettings.CharacterLimit and InputSettings.CharacterLimit < Input.InputFrame.InputBox.Text:len() then
					Input.InputFrame.InputBox.Text = Input.InputFrame.InputBox.Text:sub(1, InputSettings.CharacterLimit)
				end
				
				if InputSettings.NumbersOnly then
					Input.InputFrame.InputBox.Text = Input.InputFrame.InputBox.Text:gsub('%D+', '')
				end
			end)

			Input.InputFrame.InputBox.FocusLost:Connect(function(Enter)
				TweenService:Create(Input.InputFrame, TweenInfo.new(0.55, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Size = UDim2.new(0, Input.InputFrame.InputBox.TextBounds.X + 24, 0, 30)}):Play()
				
				if InputSettings.OnEnter and not Enter then
					if InputSettings.RemoveTextAfterFocusLost then
						Input.InputFrame.InputBox.Text = ""
						Input.InputFrame.Size = UDim2.new(0, Input.InputFrame.InputBox.TextBounds.X + 24, 0, 30)
					end
					return
				end
				
				local Success, Response = pcall(function()
					InputSettings.Callback(Input.InputFrame.InputBox.Text)
				end)
				
				if not Success then
					TweenService:Create(Input, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {BackgroundColor3 = Color3.fromRGB(85, 0, 0)}):Play()
					TweenService:Create(Input.UIStroke, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {Transparency = 1}):Play()
					Input.Title.Text = "Callback Error"
					print("Ssamachi | " .. InputSettings.Name .. " Callback Error " .. tostring(Response))
					
					wait(0.5)
					
					Input.Title.Text = InputSettings.Name
					TweenService:Create(Input, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {BackgroundColor3 = SelectedTheme.ElementBackground}):Play()
					TweenService:Create(Input.UIStroke, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {Transparency = 0}):Play()
				end

				if InputSettings.RemoveTextAfterFocusLost then
					Input.InputFrame.InputBox.Text = ""
				end
				
				SaveConfiguration()
			end)

			Input.MouseEnter:Connect(function()
				TweenService:Create(Input, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {BackgroundColor3 = SelectedTheme.ElementBackgroundHover}):Play()
			end)

			Input.MouseLeave:Connect(function()
				TweenService:Create(Input, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {BackgroundColor3 = SelectedTheme.ElementBackground}):Play()
			end)

			Input.InputFrame.InputBox.Focused:Connect(function()
				TweenService:Create(Input.InputFrame, TweenInfo.new(0.55, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Size = UDim2.new(0, Input.InputFrame.InputBox.TextBounds.X + 24, 0, 30)}):Play()
				
				if InputSettings.Locked then
					Input.InputFrame.InputBox:ReleaseFocus()
					return
				end
			end)

			function InputSettings:Destroy()
				Input:Destroy()
			end
			
			function InputSettings:Lock(Reason)
				if InputSettings.Locked then
					return
				end
				
				InputSettings.Locked = true
				Input.Lock.Reason.Text = Reason or 'Locked'
				TweenService:Create(Input.Lock, TweenInfo.new(0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundTransparency = 0}):Play()
				TweenService:Create(Input.Lock.Reason, TweenInfo.new(0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {TextTransparency = 0}):Play()
				
				wait(0.2)
				
				if not InputSettings.Locked then
					return
				end
				
				TweenService:Create(Input.Lock.Reason.Icon, TweenInfo.new(0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {ImageTransparency = 0}):Play()
			end
			
			function InputSettings:Unlock()
				if not InputSettings.Locked then
					return
				end
				
				InputSettings.Locked = false
				
				wait(0.2)
				
				TweenService:Create(Input.Lock.Reason.Icon, TweenInfo.new(0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {ImageTransparency = 1}):Play()
				
				if InputSettings.Locked then
					return
				end
				
				TweenService:Create(Input.Lock, TweenInfo.new(0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundTransparency = 1}):Play()
				TweenService:Create(Input.Lock.Reason, TweenInfo.new(0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {TextTransparency = 1}):Play()
			end
			
			function InputSettings:Visible(Bool)
				Input.Visible = Bool
			end
			
			return InputSettings
		end

		function Tab:CreateDropdown(DropdownSettings)
			local Dropdown = Elements.Template.Dropdown:Clone()
			local SearchBar = Dropdown.List["-SearchBar"]
			local Required = 1
			
			DropdownSettings.Items = {
				Selected = {Default = DropdownSettings.Selected or nil}
			}
			
			AddInfos(Dropdown, DropdownSettings, 'dropdown')
			DropdownSettings.Locked = false
			local Multi = DropdownSettings.MultiSelection or false
			
			if string.find(DropdownSettings.Name, "closed") then
				Dropdown.Name = "Dropdown"
			else
				Dropdown.Name = DropdownSettings.Name
			end
			
			Dropdown.Title.Text = DropdownSettings.Name
			Dropdown.Visible = true
			
			Tab.Elements[DropdownSettings.Name] = {
				type = 'dropdown',
				section = DropdownSettings.SectionParent,
				element = Dropdown
			}
			
			if DropdownSettings.SectionParent then
				Dropdown.Parent = DropdownSettings.SectionParent.Holder
			else
				Dropdown.Parent = TabPage
			end

			Dropdown.List.Visible = false
			Dropdown.BackgroundTransparency = 1
			Dropdown.UIStroke.Transparency = 1
			Dropdown.Title.TextTransparency = 1

			Dropdown.Size = UDim2.new(0, 465, 0, 44)

			TweenService:Create(Dropdown, TweenInfo.new(0.7, Enum.EasingStyle.Quint), {BackgroundTransparency = 0}):Play()
			TweenService:Create(Dropdown.UIStroke, TweenInfo.new(0.7, Enum.EasingStyle.Quint), {Transparency = 0}):Play()
			TweenService:Create(Dropdown.Title, TweenInfo.new(0.7, Enum.EasingStyle.Quint), {TextTransparency = 0}):Play()	

			for _, UnunusedOption in ipairs(Dropdown.List:GetChildren()) do
				if UnunusedOption.ClassName == "Frame" and UnunusedOption.Name ~= 'PlaceHolder' and UnunusedOption.Name ~= "-SearchBar" then
					UnunusedOption:Destroy()
				end
			end

			Dropdown.Toggle.Rotation = 180

			local function GetOptionInstance(Name)
				for I, V in pairs(Dropdown.List:GetChildren()) do
					if typeof(Name) == "Instance" and V.Name == Name.Name or V.Name == Name or V == Name then
						TweenService:Create(V, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {BackgroundColor3 = Color3.fromRGB(30, 30, 30)}):Play()
						return V
					end
				end
			end

			local function RefreshSelected(Boolean)
				if #DropdownSettings.Items.Selected > 0 then
					local NT = {}
					
					for _, Kj in ipairs(DropdownSettings.Items.Selected) do
						if Boolean and typeof(Kj.Option) == "Instance" then
							for _, V in pairs(Dropdown.List:GetChildren()) do
								if V.ClassName == "Frame" and V.Name ~= 'PlaceHolder' and V.Name ~= "-SearchBar" then
									TweenService:Create(V, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {BackgroundColor3 = Color3.fromRGB(30, 30, 30)}):Play()
								end
							end
							TweenService:Create(Kj.Option, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {BackgroundColor3 = Color3.fromRGB(40, 40, 40)}):Play()
						end
						
						NT[#NT + 1] = Kj.Name
					end
					
					Dropdown.Selected.Text = table.concat(NT, ", ")
				else
					Dropdown.Selected.Text = "Select an option"
				end
			end

			Dropdown.Interact.MouseButton1Click:Connect(function()
				if DropdownSettings.Locked then
					return
				end
				
				TweenService:Create(Dropdown, TweenInfo.new(0.4, Enum.EasingStyle.Quint), {BackgroundColor3 = SelectedTheme.ElementBackgroundHover}):Play()
				TweenService:Create(Dropdown.UIStroke, TweenInfo.new(0.4, Enum.EasingStyle.Quint), {Transparency = 1}):Play()
				
				wait(0.1)
				
				TweenService:Create(Dropdown, TweenInfo.new(0.4, Enum.EasingStyle.Quint), {BackgroundColor3 = SelectedTheme.ElementBackground}):Play()
				TweenService:Create(Dropdown.UIStroke, TweenInfo.new(0.4, Enum.EasingStyle.Quint), {Transparency = 0}):Play()
				
				if Debounce then
					return
				end
				
				if Dropdown.List.Visible then
					Debounce = true
					
					TweenService:Create(Dropdown, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {Size = UDim2.new(0, 465, 0, 44)}):Play()
					
					for _, DropdownOpt in ipairs(Dropdown.List:GetChildren()) do
						if DropdownOpt.ClassName == "Frame" and DropdownOpt.Name ~= 'PlaceHolder' and DropdownOpt ~= SearchBar then
							TweenService:Create(DropdownOpt, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {BackgroundTransparency = 1}):Play()
							TweenService:Create(DropdownOpt.UIStroke, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {Transparency = 1}):Play()
							TweenService:Create(DropdownOpt.Title, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {TextTransparency = 1}):Play()
						end
					end
					
					TweenService:Create(Dropdown.List, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {ScrollBarImageTransparency = 1}):Play()
					TweenService:Create(Dropdown.Toggle, TweenInfo.new(0.7, Enum.EasingStyle.Quint), {Rotation = 180}):Play()	
					
					wait(0.35)
					
					Dropdown.List.Visible = false
					Debounce = false
				else
					TweenService:Create(Dropdown, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {Size = UDim2.new(0, 465, 0, 178)}):Play()
					Dropdown.List.Visible = true
					TweenService:Create(Dropdown.List, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {ScrollBarImageTransparency = 0.7}):Play()
					TweenService:Create(Dropdown.Toggle, TweenInfo.new(0.7, Enum.EasingStyle.Quint), {Rotation = 0}):Play()	
					
					for _, DropdownOpt in ipairs(Dropdown.List:GetChildren()) do
						if DropdownOpt.ClassName == "Frame" and DropdownOpt.Name ~= 'PlaceHolder' and DropdownOpt ~= SearchBar then
							TweenService:Create(DropdownOpt, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {BackgroundTransparency = 0}):Play()
							TweenService:Create(DropdownOpt.UIStroke, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {Transparency = 0}):Play()
							TweenService:Create(DropdownOpt.Title, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {TextTransparency = 0}):Play()
						end
					end
				end
			end)

			Dropdown.List['-SearchBar'].Input:GetPropertyChangedSignal('Text'):Connect(function()
				local InputText = string.upper(Dropdown.List['-SearchBar'].Input.Text)
				
				for _, Item in ipairs(Dropdown.List:GetChildren()) do
					if Item:IsA('Frame') and Item.Name ~= 'Template' and Item ~= SearchBar and Item.Name ~= 'PlaceHolder' then
						if InputText == "" or InputText == " " or string.find(string.upper(Item.Name), InputText) ~= nil then
							TweenService:Create(Item, TweenInfo.new(0.15, Enum.EasingStyle.Quint), {BackgroundTransparency = 0}):Play()
							TweenService:Create(Item.UIStroke, TweenInfo.new(0.15, Enum.EasingStyle.Quint), {Transparency = 0}):Play()
							TweenService:Create(Item.Title, TweenInfo.new(0.15, Enum.EasingStyle.Quint), {TextTransparency = 0}):Play()
						else
							TweenService:Create(Item, TweenInfo.new(0.15, Enum.EasingStyle.Quint), {BackgroundTransparency = 1}):Play()
							TweenService:Create(Item.UIStroke, TweenInfo.new(0.15, Enum.EasingStyle.Quint), {Transparency = 1}):Play()
							TweenService:Create(Item.Title, TweenInfo.new(0.15, Enum.EasingStyle.Quint), {TextTransparency = 1}):Play()
						end
					end
				end
			end)

			Dropdown.MouseEnter:Connect(function()
				if not Dropdown.List.Visible then
					TweenService:Create(Dropdown, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {BackgroundColor3 = SelectedTheme.ElementBackgroundHover}):Play()
				end
			end)

			Dropdown.MouseLeave:Connect(function()
				TweenService:Create(Dropdown, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {BackgroundColor3 = SelectedTheme.ElementBackground}):Play()
			end)

			local function Error(Text)
				TweenService:Create(Dropdown, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {BackgroundColor3 = Color3.fromRGB(85, 0, 0)}):Play()
				TweenService:Create(Dropdown.UIStroke, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {Transparency = 1}):Play()
				Dropdown.Title.Text = Text
				
				wait(0.5)
				
				Dropdown.Title.Text = DropdownSettings.Name
				TweenService:Create(Dropdown, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {BackgroundColor3 = SelectedTheme.ElementBackground}):Play()
				TweenService:Create(Dropdown.UIStroke, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {Transparency = 0}):Play()
			end

			local function AddOption(Option, Selecteds)
				local DropdownOption = Elements.Template.Dropdown.List.Template:Clone()
				
				DropdownOption:GetPropertyChangedSignal('BackgroundTransparency'):Connect(function()
					if DropdownOption.BackgroundTransparency == 1 then
						DropdownOption.Visible = false
					else
						DropdownOption.Visible = true
					end
				end)
				
				DropdownSettings.Items[Option] = {
					Option = DropdownOption,
					Name = Option.Name or Option,
					Selected = false
				}
				
				local OptionInTable = DropdownSettings.Items[Option]
				DropdownOption.Name = Option.Name or Option
				DropdownOption.Title.Text = Option.Name or Option
				DropdownOption.Parent = Dropdown.List
				DropdownOption.Visible = true
				
				local IsSelected = OptionInTable.Selected
				
				if typeof(Selecteds) == 'string' then
					Selecteds = {Selecteds}
				end
				
				if Selecteds and #Selecteds > 0 then
					for Index, Selected in pairs(Selecteds) do
						if Selected == Option then
							IsSelected = true
							OptionInTable.Selected = true
							table.insert(DropdownSettings.Items.Selected, OptionInTable)
							DropdownSettings.Items.Selected[table.find(DropdownSettings.Items.Selected, OptionInTable)].Selected = true
						end
					end
					RefreshSelected()
				end

				if IsSelected then
					DropdownOption.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
				end

				if Dropdown.Visible then
					DropdownOption.BackgroundTransparency = 0
					DropdownOption.UIStroke.Transparency = 0
					DropdownOption.Title.TextTransparency = 0
				else
					DropdownOption.BackgroundTransparency = 1
					DropdownOption.UIStroke.Transparency = 1
					DropdownOption.Title.TextTransparency = 1
				end

				DropdownOption.Interact.ZIndex = 50
				DropdownOption.Interact.MouseButton1Click:Connect(function()
					if DropdownSettings.Locked then
						return
					end
					
					if DropdownOption.BackgroundColor3 == Color3.fromRGB(30, 30, 30) then
						OptionInTable.Selected = false
					else
						OptionInTable.Selected = true
					end
					
					if OptionInTable.Selected then
						OptionInTable.Selected = false
						table.remove(DropdownSettings.Items.Selected, table.find(DropdownSettings.Items.Selected, OptionInTable))
						
						local Success, Response = pcall(function()
							DropdownSettings.Callback(Option, DropdownSettings.Items.Selected)
						end)
						
						if not Success then
							Error('Callback Error')
							print("Ssamachi | " .. DropdownSettings.Name .. " Callback Error " .. tostring(Response))
						end
						
						RefreshSelected()
						TweenService:Create(DropdownOption, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {BackgroundColor3 = Color3.fromRGB(30, 30, 30)}):Play()
						
						SaveConfiguration()
						return
					end
					
					if not Multi and DropdownSettings.Items.Selected[1] then
						DropdownSettings.Items.Selected[1].Selected = false
						
						if typeof(DropdownSettings.Items.Selected[1]["Option"]) == "Instance" then
							TweenService:Create(DropdownSettings.Items.Selected[1].Option, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {BackgroundColor3 = Color3.fromRGB(30, 30, 30)}):Play()
						end
					end
					
					if not (Multi) then
						DropdownSettings.Items.Selected = {OptionInTable}
						Dropdown.Selected.Text = Option.Name or Option
					else
						table.insert(DropdownSettings.Items.Selected, OptionInTable)
						RefreshSelected()
					end

					local Success, Response = pcall(function()
						DropdownSettings.Callback(Option, DropdownSettings.Items.Selected)
					end)
					
					if not Success then
						Error('Callback Error')
						print("Ssamachi | " .. DropdownSettings.Name .. " Callback Error " .. tostring(Response))
					end

					OptionInTable.Selected = true

					if not (Multi) then
						for _, Op in ipairs(DropdownSettings.Items.Selected) do
							if typeof(Op) == "Instance" then
								TweenService:Create(Op.Option, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {BackgroundColor3 = Color3.fromRGB(30, 30, 30)}):Play()
							end
						end
					end
					
					TweenService:Create(DropdownOption.UIStroke, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {Transparency = 1}):Play()
					TweenService:Create(DropdownOption, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {BackgroundColor3 = Color3.fromRGB(40, 40, 40)}):Play()
					
					Debounce = true
					
					wait(0.2)
					
					TweenService:Create(DropdownOption.UIStroke, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {Transparency = 0}):Play()
					
					wait(0.1)
					
					if not Multi then
						TweenService:Create(Dropdown, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {Size = UDim2.new(0, 465, 0, 45)}):Play()
						
						for _, DropdownOpt in ipairs(Dropdown.List:GetChildren()) do
							if DropdownOpt.ClassName == "Frame" and DropdownOpt.Name ~= "PlaceHolder" and DropdownOpt ~= SearchBar then
								TweenService:Create(DropdownOpt, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {BackgroundTransparency = 1}):Play()
								TweenService:Create(DropdownOpt.UIStroke, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {Transparency = 1}):Play()
								TweenService:Create(DropdownOpt.Title, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {TextTransparency = 1}):Play()
							end
						end
						
						TweenService:Create(Dropdown.List, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {ScrollBarImageTransparency = 1}):Play()
						TweenService:Create(Dropdown.Toggle, TweenInfo.new(0.7, Enum.EasingStyle.Quint), {Rotation = 180}):Play()	
						
						wait(0.35)
						
						Dropdown.List.Visible = false
					end
					
					Debounce = false
					SaveConfiguration()
				end)
			end
			
			local function AddOptions(Options, Selected)
				if typeof(Options) == 'table' then
					for _, Option in ipairs(Options) do
						AddOption(Option, Selected)
					end
				else
					AddOption(Options, Selected)
				end
				
				if Settings.ConfigurationSaving then
					if Settings.ConfigurationSaving.Enabled and DropdownSettings.Flag then
						SsamachiLibrary.Flags[DropdownSettings.Flag] = DropdownSettings
					end
				end
			end
			
			function DropdownSettings:Add(Items, Selected)
				AddOptions(Items, Selected)
			end

			AddOptions(DropdownSettings.Options, DropdownSettings.CurrentOption)

			function DropdownSettings:Set(NewOption)
				local OldNewOption = NewOption
				
				if NewOption then
					DropdownSettings.Items.Selected = {}
				end
				
				if typeof(NewOption) == 'table' then
					-- Do nothing
				else
					NewOption = {NewOption}
				end
				
				for _, O in pairs(NewOption) do
					local Items = {
						Option = GetOptionInstance(O) or O,
						Name = O.Name or O,
						Selected = true
					}
					
					table.insert(DropdownSettings.Items.Selected, Items)
					
					local Success, Response = pcall(function()
						DropdownSettings.Callback(OldNewOption, DropdownSettings.Items.Selected)
					end)
					
					if not Success then
						TweenService:Create(Dropdown, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {BackgroundColor3 = Color3.fromRGB(85, 0, 0)}):Play()
						TweenService:Create(Dropdown.UIStroke, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {Transparency = 1}):Play()
						Dropdown.Title.Text = "Callback Error"
						print("Ssamachi | " .. DropdownSettings.Name .. " Callback Error " .. tostring(Response))
						
						wait(0.5)
						
						Dropdown.Title.Text = DropdownSettings.Name
						TweenService:Create(Dropdown, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {BackgroundColor3 = SelectedTheme.ElementBackground}):Play()
						TweenService:Create(Dropdown.UIStroke, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {Transparency = 0}):Play()
					end
					
					if DropdownSettings.Items[NewOption] then
						local DropdownOption = DropdownSettings.Items[NewOption]
						DropdownOption.BackgroundColor3 = Color3.fromRGB(40, 40, 40)

						if Dropdown.Visible then
							DropdownOption.BackgroundTransparency = 0
							DropdownOption.UIStroke.Transparency = 0
							DropdownOption.Title.TextTransparency = 0
						else
							DropdownOption.BackgroundTransparency = 1
							DropdownOption.UIStroke.Transparency = 1
							DropdownOption.Title.TextTransparency = 1
						end
					end
				end
				
				RefreshSelected(true)
			end
			
			function DropdownSettings:Error(Text)
				Error(Text)
			end
			
			function DropdownSettings:Refresh(NewOptions, Selecteds)
				DropdownSettings.Items = {}
				DropdownSettings.Items.Selected = {}
				
				local Success, Response = pcall(function()
					DropdownSettings.Callback(NewOptions, DropdownSettings.Items.Selected)
				end)
				
				if not Success then
					Error('Callback Error')
					print("Ssamachi | " .. DropdownSettings.Name .. " Callback Error " .. tostring(Response))
				end
				
				for _, Option in ipairs(Dropdown.List:GetChildren()) do
					if Option.ClassName == "Frame" and Option ~= SearchBar and Option.Name ~= "Placeholder" then
						Option:Destroy()
					end
				end
				
				AddOptions(NewOptions, Selecteds)
			end
			
			function DropdownSettings:Remove(Item)
				if Item.Name ~= "Placeholder" and Item ~= SearchBar then
					if DropdownSettings.Items[Item] then
						DropdownSettings.Items[Item].Option:Destroy()
						table.remove(DropdownSettings.Items, table.find(DropdownSettings.Items, Item))
					else
						Error('Option not found.')
					end
				else
					SearchBar:Destroy()
					Error("why you trynna remove the searchbar? FINE")
				end
				
				if Dropdown.Selected.Text == Item then
					Dropdown.Selected.Text = ''
				end
			end

			function DropdownSettings:Destroy()
				Dropdown:Destroy()
			end
			
			function DropdownSettings:Lock(Reason)
				if DropdownSettings.Locked then
					return
				end
				
				DropdownSettings.Locked = true
				Debounce = true
				
				TweenService:Create(Dropdown, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {Size = UDim2.new(0, 465, 0, 44)}):Play()
				
				for _, DropdownOpt in ipairs(Dropdown.List:GetChildren()) do
					if DropdownOpt.ClassName == "Frame" and DropdownOpt.Name ~= 'PlaceHolder' and DropdownOpt.Name ~= "-SearchBar" then
						TweenService:Create(DropdownOpt, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {BackgroundTransparency = 1}):Play()
						TweenService:Create(DropdownOpt.UIStroke, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {Transparency = 1}):Play()
						TweenService:Create(DropdownOpt.Title, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {TextTransparency = 1}):Play()
					end
				end
				
				TweenService:Create(Dropdown.List, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {ScrollBarImageTransparency = 1}):Play()
				TweenService:Create(Dropdown.Toggle, TweenInfo.new(0.7, Enum.EasingStyle.Quint), {Rotation = 180}):Play()	
				
				wait(0.35)
				
				Dropdown.List.Visible = false
				Debounce = false
				
				Dropdown.Lock.Reason.Text = Reason or 'Locked'
				TweenService:Create(Dropdown.Lock, TweenInfo.new(0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundTransparency = 0}):Play()
				TweenService:Create(Dropdown.Lock.Reason, TweenInfo.new(0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {TextTransparency = 0}):Play()
				
				wait(0.2)
				
				if not DropdownSettings.Locked then
					return
				end
				
				TweenService:Create(Dropdown.Lock.Reason.Icon, TweenInfo.new(0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {ImageTransparency = 0}):Play()
			end
			
			function DropdownSettings:Unlock()
				if not DropdownSettings.Locked then
					return
				end
				
				DropdownSettings.Locked = false
				
				wait(0.2)
				
				TweenService:Create(Dropdown.Lock.Reason.Icon, TweenInfo.new(0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {ImageTransparency = 1}):Play()
				
				if DropdownSettings.Locked then
					return
				end
				
				TweenService:Create(Dropdown.Lock, TweenInfo.new(0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundTransparency = 1}):Play()
				TweenService:Create(Dropdown.Lock.Reason, TweenInfo.new(0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {TextTransparency = 1}):Play()
			end
			
			function DropdownSettings:Visible(Bool)
				Dropdown.Visible = Bool
			end
			
			return DropdownSettings
		end

		function Tab:CreateKeybind(KeybindSettings)
			local CheckingForKey = false
			local Keybind = Elements.Template.Keybind:Clone()
			Keybind.Name = KeybindSettings.Name
			Keybind.Title.Text = KeybindSettings.Name
			Keybind.Visible = true
			
			Tab.Elements[KeybindSettings.Name] = {
				type = 'keybind',
				section = KeybindSettings.SectionParent,
				element = Keybind
			}
			
			if KeybindSettings.SectionParent then
				Keybind.Parent = KeybindSettings.SectionParent.Holder
			else
				Keybind.Parent = TabPage
			end
			
			AddInfos(Keybind, KeybindSettings, 'keybind')

			Keybind.BackgroundTransparency = 1
			Keybind.UIStroke.Transparency = 1
			Keybind.Title.TextTransparency = 1

			Keybind.KeybindFrame.BackgroundColor3 = SelectedTheme.InputBackground
			Keybind.KeybindFrame.UIStroke.Color = SelectedTheme.InputStroke

			TweenService:Create(Keybind, TweenInfo.new(0.7, Enum.EasingStyle.Quint), {BackgroundTransparency = 0}):Play()
			TweenService:Create(Keybind.UIStroke, TweenInfo.new(0.7, Enum.EasingStyle.Quint), {Transparency = 0}):Play()
			TweenService:Create(Keybind.Title, TweenInfo.new(0.7, Enum.EasingStyle.Quint), {TextTransparency = 0}):Play()	

			Keybind.KeybindFrame.KeybindBox.Text = KeybindSettings.CurrentKeybind
			Keybind.KeybindFrame.Size = UDim2.new(0, Keybind.KeybindFrame.KeybindBox.TextBounds.X + 24, 0, 30)

			Keybind.KeybindFrame.KeybindBox.Focused:Connect(function()
				if KeybindSettings.Locked then
					Keybind.KeybindFrame.KeybindBox:ReleaseFocus()
					return
				end
				
				CheckingForKey = true
				Keybind.KeybindFrame.KeybindBox.Text = ""
			end)
			
			Keybind.KeybindFrame.KeybindBox.FocusLost:Connect(function()
				CheckingForKey = false
				
				if Keybind.KeybindFrame.KeybindBox.Text == nil or "" then
					Keybind.KeybindFrame.KeybindBox.Text = KeybindSettings.CurrentKeybind
					SaveConfiguration()
				end
			end)

			Keybind.MouseEnter:Connect(function()
				TweenService:Create(Keybind, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {BackgroundColor3 = SelectedTheme.ElementBackgroundHover}):Play()
			end)

			Keybind.MouseLeave:Connect(function()
				TweenService:Create(Keybind, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {BackgroundColor3 = SelectedTheme.ElementBackground}):Play()
			end)

			UserInputService.InputBegan:Connect(function(Input, Processed)
				if CheckingForKey then
					if Input.KeyCode ~= Enum.KeyCode.Unknown and Input.KeyCode ~= Enum.KeyCode.RightShift then
						local SplitMessage = string.split(tostring(Input.KeyCode), ".")
						local NewKeyNoEnum = SplitMessage[3]
						
						Keybind.KeybindFrame.KeybindBox.Text = tostring(NewKeyNoEnum)
						KeybindSettings.CurrentKeybind = tostring(NewKeyNoEnum)
						Keybind.KeybindFrame.KeybindBox:ReleaseFocus()
						
						SaveConfiguration()
					end
				elseif KeybindSettings.CurrentKeybind ~= nil and (Input.KeyCode == Enum.KeyCode[KeybindSettings.CurrentKeybind] and not Processed) then
					local Held = true
					local Connection
					
					Connection = Input.Changed:Connect(function(Prop)
						if Prop == "UserInputState" then
							Connection:Disconnect()
							Held = false
						end
					end)

					if not KeybindSettings.HoldToInteract then
						local Success, Response = pcall(KeybindSettings.Callback)
						
						if not Success then
							TweenService:Create(Keybind, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {BackgroundColor3 = Color3.fromRGB(85, 0, 0)}):Play()
							TweenService:Create(Keybind.UIStroke, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {Transparency = 1}):Play()
							Keybind.Title.Text = "Callback Error"
							print("Ssamachi | " .. KeybindSettings.Name .. " Callback Error " .. tostring(Response))
							
							wait(0.5)
							
							Keybind.Title.Text = KeybindSettings.Name
							TweenService:Create(Keybind, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {BackgroundColor3 = SelectedTheme.ElementBackground}):Play()
							TweenService:Create(Keybind.UIStroke, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {Transparency = 0}):Play()
						end
					else
						wait(0.25)
						
						if Held then
							local Loop
							Loop = RunService.Stepped:Connect(function()
								if not Held then
									KeybindSettings.Callback(false)
									Loop:Disconnect()
								else
									KeybindSettings.Callback(true)
								end
							end)	
						end
					end
				end
			end)

			Keybind.KeybindFrame.KeybindBox:GetPropertyChangedSignal("Text"):Connect(function()
				TweenService:Create(Keybind.KeybindFrame, TweenInfo.new(0.55, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Size = UDim2.new(0, Keybind.KeybindFrame.KeybindBox.TextBounds.X + 24, 0, 30)}):Play()
			end)

			function KeybindSettings:Set(NewKeybind)
				Keybind.KeybindFrame.KeybindBox.Text = tostring(NewKeybind)
				KeybindSettings.CurrentKeybind = tostring(NewKeybind)
				Keybind.KeybindFrame.KeybindBox:ReleaseFocus()
				SaveConfiguration()
			end
			
			function KeybindSettings:Destroy()
				Keybind:Destroy()
			end
			
			function KeybindSettings:Lock(Reason)
				if KeybindSettings.Locked then
					return
				end
				
				KeybindSettings.Locked = true
				Keybind.Lock.Reason.Text = Reason or 'Locked'
				TweenService:Create(Keybind.Lock, TweenInfo.new(0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundTransparency = 0}):Play()
				TweenService:Create(Keybind.Lock.Reason, TweenInfo.new(0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {TextTransparency = 0}):Play()
				
				wait(0.2)
				
				if not KeybindSettings.Locked then
					return
				end
				
				TweenService:Create(Keybind.Lock.Reason.Icon, TweenInfo.new(0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {ImageTransparency = 0}):Play()
			end
			
			function KeybindSettings:Unlock()
				if not KeybindSettings.Locked then
					return
				end
				
				KeybindSettings.Locked = false
				
				wait(0.2)
				
				TweenService:Create(Keybind.Lock.Reason.Icon, TweenInfo.new(0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {ImageTransparency = 1}):Play()
				
				if KeybindSettings.Locked then
					return
				end
				
				TweenService:Create(Keybind.Lock, TweenInfo.new(0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundTransparency = 1}):Play()
				TweenService:Create(Keybind.Lock.Reason, TweenInfo.new(0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {TextTransparency = 1}):Play()
			end
			
			function KeybindSettings:Visible(Bool)
				Keybind.Visible = Bool
			end
			
			if Settings.ConfigurationSaving then
				if Settings.ConfigurationSaving.Enabled and KeybindSettings.Flag then
					SsamachiLibrary.Flags[KeybindSettings.Flag] = KeybindSettings
				end
			end
			
			return KeybindSettings
		end

		function Tab:CreateToggle(ToggleSettings)
			local Toggle = Elements.Template.Toggle:Clone()
			Toggle.Name = ToggleSettings.Name
			Toggle.Title.Text = ToggleSettings.Name
			Toggle.Visible = true

			Toggle.BackgroundTransparency = 1
			Toggle.UIStroke.Transparency = 1
			Toggle.Title.TextTransparency = 1
			Toggle.Switch.BackgroundColor3 = SelectedTheme.ToggleBackground
			
			Tab.Elements[Toggle.Name] = {
				type = 'toggle',
				section = ToggleSettings.SectionParent,
				element = Toggle
			}
			
			AddInfos(Toggle, ToggleSettings, 'toggle')
			
			if ToggleSettings.SectionParent then
				Toggle.Parent = ToggleSettings.SectionParent.Holder
			else
				Toggle.Parent = TabPage
			end
			
			if SelectedTheme ~= SsamachiLibrary.Theme.Default then
				Toggle.Switch.Shadow.Visible = false
			end
			
			ToggleSettings.Locked = false
			
			TweenService:Create(Toggle, TweenInfo.new(0.7, Enum.EasingStyle.Quint), {BackgroundTransparency = 0}):Play()
			TweenService:Create(Toggle.UIStroke, TweenInfo.new(0.7, Enum.EasingStyle.Quint), {Transparency = 0}):Play()
			TweenService:Create(Toggle.Title, TweenInfo.new(0.7, Enum.EasingStyle.Quint), {TextTransparency = 0}):Play()	

			if not ToggleSettings.CurrentValue then
				Toggle.Switch.Indicator.Position = UDim2.new(1, -40, 0.5, 0)
				Toggle.Switch.Indicator.UIStroke.Color = SelectedTheme.ToggleDisabledStroke
				Toggle.Switch.Indicator.BackgroundColor3 = SelectedTheme.ToggleDisabled
				Toggle.Switch.UIStroke.Color = SelectedTheme.ToggleDisabledOuterStroke
			else
				Toggle.Switch.Indicator.Position = UDim2.new(1, -20, 0.5, 0)
				Toggle.Switch.Indicator.UIStroke.Color = SelectedTheme.ToggleEnabledStroke
				Toggle.Switch.Indicator.BackgroundColor3 = SelectedTheme.ToggleEnabled
				Toggle.Switch.UIStroke.Color = SelectedTheme.ToggleEnabledOuterStroke
			end

			Toggle.MouseEnter:Connect(function()
				TweenService:Create(Toggle, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {BackgroundColor3 = SelectedTheme.ElementBackgroundHover}):Play()
			end)

			Toggle.MouseLeave:Connect(function()
				TweenService:Create(Toggle, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {BackgroundColor3 = SelectedTheme.ElementBackground}):Play()
			end)
			
			Toggle.Interact.MouseButton1Click:Connect(function()
				if ToggleSettings.Locked then
					return
				end
				
				if ToggleSettings.CurrentValue then
					ToggleSettings.CurrentValue = false
					
					TweenService:Create(Toggle, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {BackgroundColor3 = SelectedTheme.ElementBackgroundHover}):Play()
					TweenService:Create(Toggle.UIStroke, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {Transparency = 1}):Play()
					TweenService:Create(Toggle.Switch.Indicator, TweenInfo.new(0.45, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Position = UDim2.new(1, -40, 0.5, 0)}):Play()
					TweenService:Create(Toggle.Switch.Indicator, TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = UDim2.new(0, 12, 0, 12)}):Play()
					TweenService:Create(Toggle.Switch.Indicator.UIStroke, TweenInfo.new(0.55, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Color = SelectedTheme.ToggleDisabledStroke}):Play()
					TweenService:Create(Toggle.Switch.Indicator, TweenInfo.new(0.8, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundColor3 = SelectedTheme.ToggleDisabled}):Play()
					TweenService:Create(Toggle.Switch.UIStroke, TweenInfo.new(0.55, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Color = SelectedTheme.ToggleDisabledOuterStroke}):Play()
					
					wait(0.05)
					
					TweenService:Create(Toggle.Switch.Indicator, TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = UDim2.new(0, 17, 0, 17)}):Play()
					
					wait(0.15)
					
					TweenService:Create(Toggle, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {BackgroundColor3 = SelectedTheme.ElementBackground}):Play()
					TweenService:Create(Toggle.UIStroke, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {Transparency = 0}):Play()	
				else
					ToggleSettings.CurrentValue = true
					
					TweenService:Create(Toggle, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {BackgroundColor3 = SelectedTheme.ElementBackgroundHover}):Play()
					TweenService:Create(Toggle.UIStroke, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {Transparency = 1}):Play()
					TweenService:Create(Toggle.Switch.Indicator, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Position = UDim2.new(1, -20, 0.5, 0)}):Play()
					TweenService:Create(Toggle.Switch.Indicator, TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = UDim2.new(0, 12, 0, 12)}):Play()
					TweenService:Create(Toggle.Switch.Indicator.UIStroke, TweenInfo.new(0.55, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Color = SelectedTheme.ToggleEnabledStroke}):Play()
					TweenService:Create(Toggle.Switch.Indicator, TweenInfo.new(0.8, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundColor3 = SelectedTheme.ToggleEnabled}):Play()
					TweenService:Create(Toggle.Switch.UIStroke, TweenInfo.new(0.55, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Color = SelectedTheme.ToggleEnabledOuterStroke}):Play()
					
					wait(0.05)
					
					TweenService:Create(Toggle.Switch.Indicator, TweenInfo.new(0.45, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = UDim2.new(0, 17, 0, 17)}):Play()	
					
					wait(0.15)
					
					TweenService:Create(Toggle, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {BackgroundColor3 = SelectedTheme.ElementBackground}):Play()
					TweenService:Create(Toggle.UIStroke, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {Transparency = 0}):Play()		
				end

				local Success, Response = pcall(function()
					ToggleSettings.Callback(ToggleSettings.CurrentValue)
				end)
				
				if not Success then
					TweenService:Create(Toggle, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {BackgroundColor3 = Color3.fromRGB(85, 0, 0)}):Play()
					TweenService:Create(Toggle.UIStroke, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {Transparency = 1}):Play()
					Toggle.Title.Text = "Callback Error"
					print("Ssamachi | " .. ToggleSettings.Name .. " Callback Error " .. tostring(Response))
					
					wait(0.5)
					
					Toggle.Title.Text = ToggleSettings.Name
					TweenService:Create(Toggle, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {BackgroundColor3 = SelectedTheme.ElementBackground}):Play()
					TweenService:Create(Toggle.UIStroke, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {Transparency = 0}):Play()
				end

				SaveConfiguration()
			end)
			
			function ToggleSettings:Set(NewToggleValue)
				if NewToggleValue then
					ToggleSettings.CurrentValue = true
					
					TweenService:Create(Toggle, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {BackgroundColor3 = SelectedTheme.ElementBackgroundHover}):Play()
					TweenService:Create(Toggle.UIStroke, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {Transparency = 1}):Play()
					TweenService:Create(Toggle.Switch.Indicator, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Position = UDim2.new(1, -20, 0.5, 0)}):Play()
					TweenService:Create(Toggle.Switch.Indicator, TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = UDim2.new(0, 12, 0, 12)}):Play()
					TweenService:Create(Toggle.Switch.Indicator.UIStroke, TweenInfo.new(0.55, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Color = SelectedTheme.ToggleEnabledStroke}):Play()
					TweenService:Create(Toggle.Switch.Indicator, TweenInfo.new(0.8, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundColor3 = SelectedTheme.ToggleEnabled}):Play()
					TweenService:Create(Toggle.Switch.UIStroke, TweenInfo.new(0.55, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Color = Color3.fromRGB(100, 100, 100)}):Play()
					
					wait(0.05)
					
					TweenService:Create(Toggle.Switch.Indicator, TweenInfo.new(0.45, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = UDim2.new(0, 17, 0, 17)}):Play()	
					
					wait(0.15)
					
					TweenService:Create(Toggle, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {BackgroundColor3 = SelectedTheme.ElementBackground}):Play()
					TweenService:Create(Toggle.UIStroke, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {Transparency = 0}):Play()	
				else
					ToggleSettings.CurrentValue = false
					
					TweenService:Create(Toggle, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {BackgroundColor3 = SelectedTheme.ElementBackgroundHover}):Play()
					TweenService:Create(Toggle.UIStroke, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {Transparency = 1}):Play()
					TweenService:Create(Toggle.Switch.Indicator, TweenInfo.new(0.45, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Position = UDim2.new(1, -40, 0.5, 0)}):Play()
					TweenService:Create(Toggle.Switch.Indicator, TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = UDim2.new(0, 12, 0, 12)}):Play()
					TweenService:Create(Toggle.Switch.Indicator.UIStroke, TweenInfo.new(0.55, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Color = SelectedTheme.ToggleDisabledStroke}):Play()
					TweenService:Create(Toggle.Switch.Indicator, TweenInfo.new(0.8, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundColor3 = SelectedTheme.ToggleDisabled}):Play()
					TweenService:Create(Toggle.Switch.UIStroke, TweenInfo.new(0.55, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Color = Color3.fromRGB(65, 65, 65)}):Play()
					
					wait(0.05)
					
					TweenService:Create(Toggle.Switch.Indicator, TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = UDim2.new(0, 17, 0, 17)}):Play()
					
					wait(0.15)
					
					TweenService:Create(Toggle, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {BackgroundColor3 = SelectedTheme.ElementBackground}):Play()
					TweenService:Create(Toggle.UIStroke, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {Transparency = 0}):Play()	
				end
				
				local Success, Response = pcall(function()
					ToggleSettings.Callback(ToggleSettings.CurrentValue)
				end)
				
				if not Success then
					TweenService:Create(Toggle, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {BackgroundColor3 = Color3.fromRGB(85, 0, 0)}):Play()
					TweenService:Create(Toggle.UIStroke, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {Transparency = 1}):Play()
					Toggle.Title.Text = "Callback Error"
					print("Ssamachi | " .. ToggleSettings.Name .. " Callback Error " .. tostring(Response))
					
					wait(0.5)
					
					Toggle.Title.Text = ToggleSettings.Name
					TweenService:Create(Toggle, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {BackgroundColor3 = SelectedTheme.ElementBackground}):Play()
					TweenService:Create(Toggle.UIStroke, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {Transparency = 0}):Play()
				end
				
				SaveConfiguration()
			end
			
			function ToggleSettings:Destroy()
				Toggle:Destroy()
			end
			
			function ToggleSettings:Lock(Reason)
				if ToggleSettings.Locked then
					return
				end
				
				ToggleSettings.Locked = true
				Toggle.Lock.Reason.Text = Reason or 'Locked'
				TweenService:Create(Toggle.Lock, TweenInfo.new(0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundTransparency = 0}):Play()
				TweenService:Create(Toggle.Lock.Reason, TweenInfo.new(0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {TextTransparency = 0}):Play()
				
				wait(0.2)
				
				if not ToggleSettings.Locked then
					return
				end
				
				TweenService:Create(Toggle.Lock.Reason.Icon, TweenInfo.new(0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {ImageTransparency = 0}):Play()
			end
			
			function ToggleSettings:Unlock()
				if not ToggleSettings.Locked then
					return
				end
				
				ToggleSettings.Locked = false
				
				wait(0.2)
				
				TweenService:Create(Toggle.Lock.Reason.Icon, TweenInfo.new(0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {ImageTransparency = 1}):Play()
				
				if ToggleSettings.Locked then
					return
				end
				
				TweenService:Create(Toggle.Lock, TweenInfo.new(0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundTransparency = 1}):Play()
				TweenService:Create(Toggle.Lock.Reason, TweenInfo.new(0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {TextTransparency = 1}):Play()
			end
			
			function ToggleSettings:Visible(Bool)
				Toggle.Visible = Bool
			end

			if Settings.ConfigurationSaving then
				if Settings.ConfigurationSaving.Enabled and ToggleSettings.Flag then
					SsamachiLibrary.Flags[ToggleSettings.Flag] = ToggleSettings
				end
			end

			return ToggleSettings
		end

		function Tab:CreateColorPicker(ColorPickerSettings)
			local ColorPicker = Elements.Template.ColorPicker:Clone()
			
			Tab.Elements[ColorPickerSettings.Name] = {
				type = 'colorpicker',
				section = ColorPickerSettings.SectionParent,
				element = ColorPicker
			}
			
			AddInfos(ColorPicker, ColorPickerSettings, 'colorpicker')
			
			local Background = ColorPicker.CPBackground
			local Display = Background.Display
			local Main = Background.MainCP
			local Slider = ColorPicker.ColorSlider
			
			ColorPicker.ColorPickerIs.Value = false
			ColorPicker.ClipsDescendants = true
			ColorPicker.Name = ColorPickerSettings.Name
			ColorPicker.Title.Text = ColorPickerSettings.Name
			ColorPickerSettings.Locked = false
			ColorPicker.Visible = true
			
			if ColorPickerSettings.SectionParent then
				ColorPicker.Parent = ColorPickerSettings.SectionParent.Holder
			else
				ColorPicker.Parent = TabPage
			end
			
			ColorPicker.Size = UDim2.new(0, 465, 0, 40)
			ColorPicker.ColorSlider.Visible = false
			ColorPicker.HexInput.Visible = false
			ColorPicker.RGB.Visible = false
			
			Background.Size = UDim2.new(0, 39, 0, 22)
			Display.BackgroundTransparency = 0
			Main.MainPoint.ImageTransparency = 1
			ColorPicker.Interact.Size = UDim2.new(1, 0, 1, 0)
			ColorPicker.Interact.Position = UDim2.new(0.5, 0, 0.5, 0)
			ColorPicker.RGB.Position = UDim2.new(0, 17, 0, 70)
			ColorPicker.HexInput.Position = UDim2.new(0, 17, 0, 90)
			
			Main.ImageTransparency = 1
			Background.BackgroundTransparency = 1
			
			local Opened = false 
			local Mouse = game.Players.LocalPlayer:GetMouse()
			
			Main.Image = "http://www.roblox.com/asset/?id=11415645739"
			
			local MainDragging = false 
			local SliderDragging = false 
			
			ColorPicker.Interact.MouseButton1Click:Connect(function()
				if ColorPickerSettings.Locked then
					return
				end
				
				if not Opened then
					ColorPicker.ColorPickerIs.Value = true
					Opened = true 
					
					ColorPicker.ColorSlider.Visible = true
					ColorPicker.HexInput.Visible = true
					ColorPicker.RGB.Visible = true
					
					TweenService:Create(ColorPicker, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {Size = UDim2.new(0, 465, 0, 120)}):Play()
					TweenService:Create(Background, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {Size = UDim2.new(0, 173, 0, 86)}):Play()
					TweenService:Create(Display, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {BackgroundTransparency = 1}):Play()
					TweenService:Create(ColorPicker.Interact, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {Position = UDim2.new(0.289, 0, 0.5, 0)}):Play()
					TweenService:Create(ColorPicker.RGB, TweenInfo.new(0.8, Enum.EasingStyle.Quint), {Position = UDim2.new(0, 17, 0, 40)}):Play()
					TweenService:Create(ColorPicker.HexInput, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {Position = UDim2.new(0, 17, 0, 73)}):Play()
					TweenService:Create(ColorPicker.Interact, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {Size = UDim2.new(0.574, 0, 1, 0)}):Play()
					TweenService:Create(Main.MainPoint, TweenInfo.new(0.2, Enum.EasingStyle.Quint), {ImageTransparency = 0}):Play()
					TweenService:Create(Main, TweenInfo.new(0.2, Enum.EasingStyle.Quint), {ImageTransparency = 0.1}):Play()
					TweenService:Create(Background, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {BackgroundTransparency = 0}):Play()
				else
					ColorPicker.ColorPickerIs.Value = false
					Opened = false
					
					ColorPicker.ColorSlider.Visible = false
					ColorPicker.HexInput.Visible = false
					ColorPicker.RGB.Visible = false
					
					TweenService:Create(ColorPicker, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {Size = UDim2.new(0, 465, 0, 40)}):Play()
					TweenService:Create(Background, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {Size = UDim2.new(0, 39, 0, 22)}):Play()
					TweenService:Create(ColorPicker.Interact, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {Size = UDim2.new(1, 0, 1, 0)}):Play()
					TweenService:Create(ColorPicker.Interact, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {Position = UDim2.new(0.5, 0, 0.5, 0)}):Play()
					TweenService:Create(ColorPicker.RGB, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {Position = UDim2.new(0, 17, 0, 70)}):Play()
					TweenService:Create(ColorPicker.HexInput, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {Position = UDim2.new(0, 17, 0, 90)}):Play()
					TweenService:Create(Display, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {BackgroundTransparency = 0}):Play()
					TweenService:Create(Main.MainPoint, TweenInfo.new(0.2, Enum.EasingStyle.Quint), {ImageTransparency = 1}):Play()
					TweenService:Create(Main, TweenInfo.new(0.2, Enum.EasingStyle.Quint), {ImageTransparency = 1}):Play()
					TweenService:Create(Background, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {BackgroundTransparency = 1}):Play()
				end
			end)

			game:GetService("UserInputService").InputEnded:Connect(function(Input, GameProcessed)
				if (Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch) then
					TabPage.ScrollingEnabled = true
					MainDragging = false
					SliderDragging = false
				end
			end)
			
			Main.MouseButton1Down:Connect(function()
				if Opened and not ColorPickerSettings.Locked then
					TabPage.ScrollingEnabled = false
					MainDragging = true 
				end
			end)
			
			Main.MainPoint.MouseButton1Down:Connect(function()
				if Opened and not ColorPickerSettings.Locked then
					TabPage.ScrollingEnabled = false
					MainDragging = true 
				end
			end)
			
			Slider.MouseButton1Down:Connect(function()
				if ColorPickerSettings.Locked then
					return
				end
				
				TabPage.ScrollingEnabled = false
				SliderDragging = true 
			end)
			
			Slider.SliderPoint.MouseButton1Down:Connect(function()
				if ColorPickerSettings.Locked then
					return
				end
				
				TabPage.ScrollingEnabled = false
				SliderDragging = true 
			end)

			local H, S, V = ColorPickerSettings.Color:ToHSV()
			local Color = Color3.fromHSV(H, S, V) 
			local Hex = string.format("#%02X%02X%02X", Color.R * 0xFF, Color.G * 0xFF, Color.B * 0xFF)
			
			ColorPicker.HexInput.InputBox.Text = Hex
			
			local function SetDisplay()
				Main.MainPoint.Position = UDim2.new(S, -Main.MainPoint.AbsoluteSize.X / 2, 1 - V, -Main.MainPoint.AbsoluteSize.Y / 2)
				Main.MainPoint.ImageColor3 = Color3.fromHSV(H, S, V)
				Background.BackgroundColor3 = Color3.fromHSV(H, 1, 1)
				Display.BackgroundColor3 = Color3.fromHSV(H, S, V)
				
				local X = H * Slider.AbsoluteSize.X
				Slider.SliderPoint.Position = UDim2.new(0, X - Slider.SliderPoint.AbsoluteSize.X / 2, 0.5, 0)
				Slider.SliderPoint.ImageColor3 = Color3.fromHSV(H, 1, 1)
				
				local Color = Color3.fromHSV(H, S, V) 
				local R, G, B = math.floor((Color.R * 255) + 0.5), math.floor((Color.G * 255) + 0.5), math.floor((Color.B * 255) + 0.5)
				
				ColorPicker.RGB.RInput.InputBox.Text = tostring(R)
				ColorPicker.RGB.GInput.InputBox.Text = tostring(G)
				ColorPicker.RGB.BInput.InputBox.Text = tostring(B)
				
				Hex = string.format("#%02X%02X%02X", Color.R * 0xFF, Color.G * 0xFF, Color.B * 0xFF)
				ColorPicker.HexInput.InputBox.Text = Hex
			end
			
			SetDisplay()
			
			ColorPicker.HexInput.InputBox.FocusLost:Connect(function()
				if not pcall(function()
					local R, G, B = string.match(ColorPicker.HexInput.InputBox.Text, "^#?(%w%w)(%w%w)(%w%w)$")
					local RgbColor = Color3.fromRGB(tonumber(R, 16), tonumber(G, 16), tonumber(B, 16))
					
					H, S, V = RgbColor:ToHSV()
					Hex = ColorPicker.HexInput.InputBox.Text
					
					SetDisplay()
					ColorPickerSettings.Color = RgbColor
				end) then 
					ColorPicker.HexInput.InputBox.Text = Hex 
				end
				
				pcall(function()
					ColorPickerSettings.Callback(Color3.fromHSV(H, S, V))
				end)
				
				local R, G, B = math.floor((H * 255) + 0.5), math.floor((S * 255) + 0.5), math.floor((V * 255) + 0.5)
				ColorPickerSettings.Color = Color3.fromRGB(R, G, B)
				
				SaveConfiguration()
			end)

			local function RgbBoxes(Box, ToChange)
				local Value = tonumber(Box.Text) 
				local Color = Color3.fromHSV(H, S, V) 
				local OldR, OldG, OldB = math.floor((Color.R * 255) + 0.5), math.floor((Color.G * 255) + 0.5), math.floor((Color.B * 255) + 0.5)
				local Save 
				
				if ToChange == "R" then
					Save = OldR
					OldR = Value 
				elseif ToChange == "G" then
					Save = OldG
					OldG = Value 
				else
					Save = OldB
					OldB = Value 
				end
				
				if Value then 
					Value = math.clamp(Value, 0, 255)
					H, S, V = Color3.fromRGB(OldR, OldG, OldB):ToHSV()

					SetDisplay()
				else 
					Box.Text = tostring(Save)
				end
				
				local R, G, B = math.floor((H * 255) + 0.5), math.floor((S * 255) + 0.5), math.floor((V * 255) + 0.5)
				ColorPickerSettings.Color = Color3.fromRGB(R, G, B)
				
				SaveConfiguration()
			end

			ColorPicker.RGB.RInput.InputBox.FocusLost:connect(function()
				RgbBoxes(ColorPicker.RGB.RInput.InputBox, "R")
				pcall(function()
					ColorPickerSettings.Callback(Color3.fromHSV(H, S, V))
				end)
			end)
			
			ColorPicker.RGB.GInput.InputBox.FocusLost:connect(function()
				RgbBoxes(ColorPicker.RGB.GInput.InputBox, "G")
				pcall(function()
					ColorPickerSettings.Callback(Color3.fromHSV(H, S, V))
				end)
			end)
			
			ColorPicker.RGB.BInput.InputBox.FocusLost:connect(function()
				RgbBoxes(ColorPicker.RGB.BInput.InputBox, "B")
				pcall(function()
					ColorPickerSettings.Callback(Color3.fromHSV(H, S, V))
				end)
			end)

			ColorPicker.HexInput.InputBox.Focused:Connect(function()
				if ColorPickerSettings.Locked then
					ColorPicker.HexInput.InputBox:ReleaseFocus()
					return
				end
			end)
			
			ColorPicker.RGB.RInput.InputBox.Focused:connect(function()
				if ColorPickerSettings.Locked then
					ColorPicker.RGB.RInput.InputBox:ReleaseFocus()
					return
				end
			end)
			
			ColorPicker.RGB.GInput.InputBox.Focused:connect(function()
				if ColorPickerSettings.Locked then
					ColorPicker.RGB.GInput.InputBox:ReleaseFocus()
					return
				end
			end)
			
			ColorPicker.RGB.BInput.InputBox.Focused:connect(function()
				if ColorPickerSettings.Locked then
					ColorPicker.RGB.BInput.InputBox:ReleaseFocus()
					return
				end
			end)

			game:GetService("RunService").RenderStepped:connect(function()
				if MainDragging then 
					local LocalX = math.clamp(Mouse.X - Main.AbsolutePosition.X, 0, Main.AbsoluteSize.X)
					local LocalY = math.clamp(Mouse.Y - Main.AbsolutePosition.Y, 0, Main.AbsoluteSize.Y)
					
					Main.MainPoint.Position = UDim2.new(0, LocalX - Main.MainPoint.AbsoluteSize.X / 2, 0, LocalY - Main.MainPoint.AbsoluteSize.Y / 2)
					
					S = LocalX / Main.AbsoluteSize.X
					V = 1 - (LocalY / Main.AbsoluteSize.Y)
					
					Display.BackgroundColor3 = Color3.fromHSV(H, S, V)
					Main.MainPoint.ImageColor3 = Color3.fromHSV(H, S, V)
					Background.BackgroundColor3 = Color3.fromHSV(H, 1, 1)
					
					local Color = Color3.fromHSV(H, S, V) 
					local R, G, B = math.floor((Color.R * 255) + 0.5), math.floor((Color.G * 255) + 0.5), math.floor((Color.B * 255) + 0.5)
					
					ColorPicker.RGB.RInput.InputBox.Text = tostring(R)
					ColorPicker.RGB.GInput.InputBox.Text = tostring(G)
					ColorPicker.RGB.BInput.InputBox.Text = tostring(B)
					ColorPicker.HexInput.InputBox.Text = string.format("#%02X%02X%02X", Color.R * 0xFF, Color.G * 0xFF, Color.B * 0xFF)
					
					pcall(function()
						ColorPickerSettings.Callback(Color3.fromHSV(H, S, V))
					end)
					
					ColorPickerSettings.Color = Color3.fromRGB(R, G, B)
					
					SaveConfiguration()
				end
				
				if SliderDragging then 
					local LocalX = math.clamp(Mouse.X - Slider.AbsolutePosition.X, 0, Slider.AbsoluteSize.X)
					
					H = LocalX / Slider.AbsoluteSize.X
					
					Display.BackgroundColor3 = Color3.fromHSV(H, S, V)
					Slider.SliderPoint.Position = UDim2.new(0, LocalX - Slider.SliderPoint.AbsoluteSize.X / 2, 0.5, 0)
					Slider.SliderPoint.ImageColor3 = Color3.fromHSV(H, 1, 1)
					Background.BackgroundColor3 = Color3.fromHSV(H, 1, 1)
					Main.MainPoint.ImageColor3 = Color3.fromHSV(H, S, V)
					
					local Color = Color3.fromHSV(H, S, V) 
					local R, G, B = math.floor((Color.R * 255) + 0.5), math.floor((Color.G * 255) + 0.5), math.floor((Color.B * 255) + 0.5)
					
					ColorPicker.RGB.RInput.InputBox.Text = tostring(R)
					ColorPicker.RGB.GInput.InputBox.Text = tostring(G)
					ColorPicker.RGB.BInput.InputBox.Text = tostring(B)
					ColorPicker.HexInput.InputBox.Text = string.format("#%02X%02X%02X", Color.R * 0xFF, Color.G * 0xFF, Color.B * 0xFF)
					
					pcall(function()
						ColorPickerSettings.Callback(Color3.fromHSV(H, S, V))
					end)
					
					ColorPickerSettings.Color = Color3.fromRGB(R, G, B)
					
					SaveConfiguration()
				end
			end)

			if Settings.ConfigurationSaving then
				if Settings.ConfigurationSaving.Enabled and ColorPickerSettings.Flag then
					SsamachiLibrary.Flags[ColorPickerSettings.Flag] = ColorPickerSettings
				end
			end

			function ColorPickerSettings:Set(RGBColor)
				ColorPickerSettings.Color = RGBColor
				H, S, V = ColorPickerSettings.Color:ToHSV()
				Color = Color3.fromHSV(H, S, V)
				SetDisplay()
			end
			
			function ColorPickerSettings:Destroy()
				ColorPicker:Destroy()
			end
			
			function ColorPickerSettings:Lock(Reason)
				if ColorPickerSettings.Locked then
					return
				end
				
				ColorPicker.ColorPickerIs.Value = false
				Opened = false
				
				ColorPicker.ColorSlider.Visible = false
				ColorPicker.HexInput.Visible = false
				ColorPicker.RGB.Visible = false
				
				TweenService:Create(ColorPicker, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {Size = UDim2.new(0, 465, 0, 40)}):Play()
				TweenService:Create(Background, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {Size = UDim2.new(0, 39, 0, 22)}):Play()
				TweenService:Create(ColorPicker.Interact, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {Size = UDim2.new(1, 0, 1, 0)}):Play()
				TweenService:Create(ColorPicker.Interact, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {Position = UDim2.new(0.5, 0, 0.5, 0)}):Play()
				TweenService:Create(ColorPicker.RGB, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {Position = UDim2.new(0, 17, 0, 70)}):Play()
				TweenService:Create(ColorPicker.HexInput, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {Position = UDim2.new(0, 17, 0, 90)}):Play()
				TweenService:Create(Display, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {BackgroundTransparency = 0}):Play()
				TweenService:Create(Main.MainPoint, TweenInfo.new(0.2, Enum.EasingStyle.Quint), {ImageTransparency = 1}):Play()
				TweenService:Create(Main, TweenInfo.new(0.2, Enum.EasingStyle.Quint), {ImageTransparency = 1}):Play()
				TweenService:Create(Background, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {BackgroundTransparency = 1}):Play()
				
				ColorPicker.Lock.Reason.Text = Reason or 'Locked'
				ColorPickerSettings.Locked = true
				
				TweenService:Create(ColorPicker.Lock, TweenInfo.new(0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundTransparency = 0}):Play()
				TweenService:Create(ColorPicker.Lock.Reason, TweenInfo.new(0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {TextTransparency = 0}):Play()
				
				wait(0.2)
				
				if not ColorPickerSettings.Locked then
					return
				end
				
				TweenService:Create(ColorPicker.Lock.Reason.Icon, TweenInfo.new(0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {ImageTransparency = 0}):Play()
			end
			
			function ColorPickerSettings:Unlock()
				if not ColorPickerSettings.Locked then
					return
				end
				
				ColorPickerSettings.Locked = false
				
				wait(0.2)
				
				TweenService:Create(ColorPicker.Lock.Reason.Icon, TweenInfo.new(0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {ImageTransparency = 1}):Play()
				
				if ColorPickerSettings.Locked then
					return
				end
				
				TweenService:Create(ColorPicker.Lock, TweenInfo.new(0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundTransparency = 1}):Play()
				TweenService:Create(ColorPicker.Lock.Reason, TweenInfo.new(0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {TextTransparency = 1}):Play()
			end
			
			function ColorPickerSettings:Visible(Bool)
				ColorPicker.Visible = Bool
			end
			
			return ColorPickerSettings
		end

		function Tab:CreateSlider(SliderSettings)
			local Dragging = false
			local Slider = Elements.Template.Slider:Clone()
			Slider.Name = SliderSettings.Name
			Slider.Title.Text = SliderSettings.Name
			Slider.Visible = true
			
			Tab.Elements[SliderSettings.Name] = {
				type = 'slider',
				section = SliderSettings.SectionParent,
				element = Slider
			}
			
			AddInfos(Slider, SliderSettings, 'slider')
			
			if SliderSettings.SectionParent then
				Slider.Parent = SliderSettings.SectionParent.Holder
			else
				Slider.Parent = TabPage
			end

			Slider.BackgroundTransparency = 1
			Slider.UIStroke.Transparency = 1
			Slider.Title.TextTransparency = 1

			if SelectedTheme ~= SsamachiLibrary.Theme.Default then
				Slider.Main.Shadow.Visible = false
			end

			Slider.Main.BackgroundColor3 = SelectedTheme.SliderBackground
			Slider.Main.UIStroke.Color = SelectedTheme.SliderStroke
			Slider.Main.Progress.BackgroundColor3 = SelectedTheme.SliderProgress

			TweenService:Create(Slider, TweenInfo.new(0.7, Enum.EasingStyle.Quint), {BackgroundTransparency = 0}):Play()
			TweenService:Create(Slider.UIStroke, TweenInfo.new(0.7, Enum.EasingStyle.Quint), {Transparency = 0}):Play()
			TweenService:Create(Slider.Title, TweenInfo.new(0.7, Enum.EasingStyle.Quint), {TextTransparency = 0}):Play()	

			Slider.Main.Progress.Size = UDim2.new(0, Slider.Main.AbsoluteSize.X * ((SliderSettings.CurrentValue + SliderSettings.Range[1]) / (SliderSettings.Range[2] - SliderSettings.Range[1])) > 5 and Slider.Main.AbsoluteSize.X * (SliderSettings.CurrentValue / (SliderSettings.Range[2] - SliderSettings.Range[1])) or 5, 1, 0)

			if not SliderSettings.Suffix then
				Slider.Main.Information.Text = tostring(SliderSettings.CurrentValue)
			else
				Slider.Main.Information.Text = tostring(SliderSettings.CurrentValue) .. " " .. SliderSettings.Suffix
			end

			Slider.MouseEnter:Connect(function()
				TweenService:Create(Slider, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {BackgroundColor3 = SelectedTheme.ElementBackgroundHover}):Play()
			end)
			
			Slider.Main.Interact.MouseLeave:Connect(function()
				-- Do nothing
			end)
			
			Slider.MouseLeave:Connect(function()
				TweenService:Create(Slider, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {BackgroundColor3 = SelectedTheme.ElementBackground}):Play()
			end)
			
			local function UpdateSlider(X)
				local Current = Slider.Main.Progress.AbsolutePosition.X + Slider.Main.Progress.AbsoluteSize.X
				local Start = Current
				local Location = X

				Current = Current + 0.025 * (Location - Start)

				TabPage.ScrollingEnabled = false

				if Location < Slider.Main.AbsolutePosition.X then
					Location = Slider.Main.AbsolutePosition.X
				elseif Location > Slider.Main.AbsolutePosition.X + Slider.Main.AbsoluteSize.X then
					Location = Slider.Main.AbsolutePosition.X + Slider.Main.AbsoluteSize.X
				end

				if Current < Slider.Main.AbsolutePosition.X + 5 then
					Current = Slider.Main.AbsolutePosition.X + 5
				elseif Current > Slider.Main.AbsolutePosition.X + Slider.Main.AbsoluteSize.X then
					Current = Slider.Main.AbsolutePosition.X + Slider.Main.AbsoluteSize.X
				end

				if Current <= Location and (Location - Start) < 0 then
					Start = Location
				elseif Current >= Location and (Location - Start) > 0 then
					Start = Location
				end
				
				TweenService:Create(Slider.Main.Progress, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.new(0, Location - Slider.Main.AbsolutePosition.X > 5 and Location - Slider.Main.AbsolutePosition.X or 5, 1, 0)}):Play()
				
				local NewValue = SliderSettings.Range[1] + (Location - Slider.Main.AbsolutePosition.X) / Slider.Main.AbsoluteSize.X * (SliderSettings.Range[2] - SliderSettings.Range[1])

				NewValue = math.floor(NewValue / SliderSettings.Increment + 0.5) * (SliderSettings.Increment * 10000000) / 10000000
				
				if not SliderSettings.Suffix then
					Slider.Main.Information.Text = tostring(NewValue)
				else
					Slider.Main.Information.Text = tostring(NewValue) .. " " .. SliderSettings.Suffix
				end

				if SliderSettings.CurrentValue ~= NewValue then
					local Success, Response = pcall(function()
						SliderSettings.Callback(NewValue)
					end)
					
					if not Success then
						TweenService:Create(Slider, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {BackgroundColor3 = Color3.fromRGB(85, 0, 0)}):Play()
						TweenService:Create(Slider.UIStroke, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {Transparency = 1}):Play()
						Slider.Title.Text = "Callback Error"
						print("Ssamachi | " .. SliderSettings.Name .. " Callback Error " .. tostring(Response))
						
						wait(0.5)
						
						Slider.Title.Text = SliderSettings.Name
						TweenService:Create(Slider, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {BackgroundColor3 = SelectedTheme.ElementBackground}):Play()
						TweenService:Create(Slider.UIStroke, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {Transparency = 0}):Play()
					end

					SliderSettings.CurrentValue = NewValue
					SaveConfiguration()
				end
			end
			
			local InputBegan, Conduct
			
			UserInputService.InputBegan:Connect(function(Input)
				if (Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch) then
					Conduct = true
					
					Input.Changed:Connect(function()
						if Input.UserInputState == Enum.UserInputState.End then
							Conduct = false
						end
					end)
				end
			end)
			
			Slider.Main.Interact.InputBegan:Connect(function(Input)
				if not SliderSettings.Locked and not Conduct then
					InputBegan = Input
					UpdateSlider(InputBegan.Position.X)
					Dragging = true
				end 
			end)
			
			UserInputService.InputEnded:Connect(function(Input)
				if (Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch) and Dragging then
					TabPage.ScrollingEnabled = true
					Dragging = false
				end
			end)
			
			UserInputService.InputChanged:Connect(function(Input)
				if SliderSettings.Locked then
					return
				end
				
				if (Input.UserInputType == Enum.UserInputType.MouseMovement or Input.UserInputType == Enum.UserInputType.Touch) and Dragging then
					UpdateSlider(InputBegan.Position.X)
				end
			end)

			function SliderSettings:Set(NewVal)
				TweenService:Create(Slider.Main.Progress, TweenInfo.new(0.45, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Size = UDim2.new(0, Slider.Main.AbsoluteSize.X * ((NewVal + SliderSettings.Range[1]) / (SliderSettings.Range[2] - SliderSettings.Range[1])) > 5 and Slider.Main.AbsoluteSize.X * (NewVal / (SliderSettings.Range[2] - SliderSettings.Range[1])) or 5, 1, 0)}):Play()
				Slider.Main.Information.Text = tostring(NewVal) .. " " .. SliderSettings.Suffix
				
				local Success, Response = pcall(function()
					SliderSettings.Callback(NewVal)
				end)
				
				if not Success then
					TweenService:Create(Slider, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {BackgroundColor3 = Color3.fromRGB(85, 0, 0)}):Play()
					TweenService:Create(Slider.UIStroke, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {Transparency = 1}):Play()
					Slider.Title.Text = "Callback Error"
					print("Ssamachi | " .. SliderSettings.Name .. " Callback Error " .. tostring(Response))
					
					wait(0.5)
					
					Slider.Title.Text = SliderSettings.Name
					TweenService:Create(Slider, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {BackgroundColor3 = SelectedTheme.ElementBackground}):Play()
					TweenService:Create(Slider.UIStroke, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {Transparency = 0}):Play()
				end
				
				SliderSettings.CurrentValue = NewVal
				SaveConfiguration()
			end
			
			function SliderSettings:Destroy()
				Slider:Destroy()
			end
			
			function SliderSettings:Lock(Reason)
				if SliderSettings.Locked then
					return
				end
				
				SliderSettings.Locked = true
				Slider.Lock.Reason.Text = Reason or 'Locked'
				TweenService:Create(Slider.Lock, TweenInfo.new(0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundTransparency = 0}):Play()
				TweenService:Create(Slider.Lock.Reason, TweenInfo.new(0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {TextTransparency = 0}):Play()
				
				wait(0.2)
				
				if not SliderSettings.Locked then
					return
				end
				
				TweenService:Create(Slider.Lock.Reason.Icon, TweenInfo.new(0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {ImageTransparency = 0}):Play()
			end
			
			function SliderSettings:Unlock()
				if not SliderSettings.Locked then
					return
				end
				
				SliderSettings.Locked = false
				
				wait(0.2)
				
				TweenService:Create(Slider.Lock.Reason.Icon, TweenInfo.new(0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {ImageTransparency = 1}):Play()
				
				if SliderSettings.Locked then
					return
				end
				
				TweenService:Create(Slider.Lock, TweenInfo.new(0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundTransparency = 1}):Play()
				TweenService:Create(Slider.Lock.Reason, TweenInfo.new(0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {TextTransparency = 1}):Play()
			end
			
			function SliderSettings:Visible(Bool)
				Slider.Visible = Bool
			end
			
			if Settings.ConfigurationSaving then
				if Settings.ConfigurationSaving.Enabled and SliderSettings.Flag then
					SsamachiLibrary.Flags[SliderSettings.Flag] = SliderSettings
				end
			end
			
			return SliderSettings
		end

		return Tab
	end

	Elements.Visible = true

	wait(1.2)
	
	TweenService:Create(LoadingFrame.Title, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {TextTransparency = 1}):Play()
	TweenService:Create(LoadingFrame.Subtitle, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {TextTransparency = 1}):Play()
	TweenService:Create(LoadingFrame.Version, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {TextTransparency = 1}):Play()
	
	wait(0.2)
	
	TweenService:Create(Main, TweenInfo.new(0.7, Enum.EasingStyle.Quint), {Size = UDim2.new(0, 500, 0, 475)}):Play()
	TweenService:Create(Main.Shadow.Image, TweenInfo.new(0.7, Enum.EasingStyle.Quint), {ImageTransparency = 0.4}):Play()

	Topbar.BackgroundTransparency = 1
	Topbar.Divider.Size = UDim2.new(0, 0, 0, 1)
	Topbar.CornerRepair.BackgroundTransparency = 1
	Topbar.Title.TextTransparency = 1
	Topbar.Theme.ImageTransparency = 1
	Topbar.ChangeSize.ImageTransparency = 1
	Topbar.Hide.ImageTransparency = 1

	wait(0.8)
	
	Topbar.Visible = true
	
	TweenService:Create(Topbar, TweenInfo.new(0.7, Enum.EasingStyle.Quint), {BackgroundTransparency = 0}):Play()
	TweenService:Create(Topbar.CornerRepair, TweenInfo.new(0.7, Enum.EasingStyle.Quint), {BackgroundTransparency = 0}):Play()
	
	wait(0.1)
	
	TweenService:Create(Topbar.Divider, TweenInfo.new(1, Enum.EasingStyle.Quint), {Size = UDim2.new(1, 0, 0, 1)}):Play()
	
	wait(0.1)
	
	TweenService:Create(Topbar.Title, TweenInfo.new(0.7, Enum.EasingStyle.Quint), {TextTransparency = 0}):Play()
	
	wait(0.1)
	
	TweenService:Create(Topbar.Theme, TweenInfo.new(0.7, Enum.EasingStyle.Quint), {ImageTransparency = 0.8}):Play()
	
	wait(0.1)
	
	TweenService:Create(Topbar.ChangeSize, TweenInfo.new(0.7, Enum.EasingStyle.Quint), {ImageTransparency = 0.8}):Play()
	
	wait(0.1)
	
	TweenService:Create(Topbar.Hide, TweenInfo.new(0.7, Enum.EasingStyle.Quint), {ImageTransparency = 0.8}):Play()
	
	wait(0.3)
	
	function Window:Prompt(PromptSettings)
		local PromptUI = Prompt.Prompt
		Prompt.Visible = true
		Prompt.BackgroundTransparency = 1
		PromptUI.BackgroundTransparency = 1
		PromptUI.UIStroke.Transparency = 1
		PromptUI.Content.TextTransparency = 1
		PromptUI.Title.TextTransparency = 1
		PromptUI.Sub.TextTransparency = 1
		PromptUI.Size = UDim2.new(0, 340, 0, 140)
		PromptUI.Buttons.Template.Visible = false
		PromptUI.Buttons.Template.TextLabel.TextTransparency = 1
		PromptUI.Buttons.Template.UIStroke.Transparency = 1

		PromptUI.Content.Text = PromptSettings.Content
		PromptUI.Sub.Text = PromptSettings.SubTitle or ''
		PromptUI.Title.Text = PromptSettings.Title or ''

		if PromptSettings.Actions then
			for Name, Info in pairs(PromptSettings.Actions) do
				local Button = PromptUI.Buttons.Template:Clone()
				Button.TextLabel.Text = Info.Name
				Button.Interact.MouseButton1Up:Connect(function()
					if not Clicked then
						local Success, Response = pcall(Info.Callback)
						Clicked = true
						
						if not Success then
							ClosePrompt()
							print("Ssamachi | " .. Info.Name .. " Callback Error " .. tostring(Response))
						else
							ClosePrompt()
						end
					end
				end)
				Button.Name = Name
				Button.Parent = PromptUI.Buttons
				Button.Size = UDim2.fromOffset(Button.TextLabel.TextBounds.X + 24, 30)
			end
		end

		TweenService:Create(Prompt, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {BackgroundTransparency = .5}):Play()
		
		wait(.2)
		
		TweenService:Create(PromptUI, TweenInfo.new(0.4, Enum.EasingStyle.Quint), {BackgroundTransparency = 0, Size = UDim2.new(0, 350, 0, 150)}):Play()
		
		wait(0.2)
		
		TweenService:Create(PromptUI.UIStroke, TweenInfo.new(0.4, Enum.EasingStyle.Quint), {Transparency = 0}):Play()
		TweenService:Create(PromptUI.Title, TweenInfo.new(0.45, Enum.EasingStyle.Quint), {TextTransparency = 0}):Play()
		TweenService:Create(PromptUI.Content, TweenInfo.new(0.45, Enum.EasingStyle.Quint), {TextTransparency = 0}):Play()
		TweenService:Create(PromptUI.Sub, TweenInfo.new(0.45, Enum.EasingStyle.Quint), {TextTransparency = 0}):Play()
		
		wait(1)
		
		if PromptSettings.Actions then
			for _, Button in pairs(PromptUI.Buttons:GetChildren()) do
				if Button.Name ~= 'Template' and Button.Name ~= 'Middle' and Button:IsA('Frame') then
					Button.Visible = true
					TweenService:Create(Button.UIStroke, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {Transparency = 0}):Play()
					TweenService:Create(Button.TextLabel, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {TextTransparency = 0}):Play()
					wait(.8)
				end
			end
		end
	end
	
	return Window
end

Topbar.ChangeSize.MouseButton1Click:Connect(function()
	if Debounce then
		return
	end
	
	if Minimised then
		Minimised = false
		Maximise()
	else
		if not SearchHided then
			SearchHided = true
			Spawn(CloseSearch)
		end
		
		Minimised = true
		Minimise()
	end
end)

Topbar.Search.MouseButton1Click:Connect(function()
	if Debounce or Minimised then
		return
	end
	
	if SearchHided then
		OpenSearch()
		SearchHided = false
	else
		SearchHided = true
		CloseSearch()
	end
end)

Topbar.Type.MouseButton1Click:Connect(function()
	if Debounce or Minimised then
		return
	end
	
	if SideBarClosed then
		Topbar.Type.Image = "rbxassetid://" .. 6023565894
		OpenSideBar()
	else
		Topbar.Type.Image = "rbxassetid://" .. 6023565896
		CloseSideBar()
	end
end)

Topbar.Hide.MouseButton1Click:Connect(function()
	if Debounce then
		return
	end
	
	if Hidden then
		Hidden = false
		Minimised = false
		Unhide()
	else
		if not SearchHided then
			SearchHided = true
			Spawn(CloseSearch)
		end
		
		Hidden = true
		Hide()
	end
end)

local FieldScreen = Instance.new("ScreenGui")
FieldScreen.DisplayOrder = 100
FieldScreen.ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets
FieldScreen.Name = "Uni" .. tostring(math.random(1000, 9999))
FieldScreen.Parent = gethui and gethui() or game:GetService("CoreGui")

local UniButton = Instance.new("ImageLabel")
UniButton.Name = "UniButton"
UniButton.Image = "rbxassetid://14958620447"
UniButton.Active = false
UniButton.ZIndex = 10
UniButton.Position = UDim2.new(0.8, 0, 0, 0)
UniButton.BorderSizePixel = 0
UniButton.BackgroundTransparency = 1
UniButton.Size = UDim2.new(0, 42, 0, 42)
UniButton.SizeConstraint = Enum.SizeConstraint.RelativeXY
UniButton.Parent = FieldScreen

local UniBoxButton = Instance.new("TextButton")
UniBoxButton.Name = "UniBoxButton"
UniBoxButton.ZIndex = 10
UniBoxButton.AnchorPoint = Vector2.new(0.5, 0)
UniBoxButton.Position = UDim2.new(0.5, 0, 0, 0)
UniBoxButton.Size = UDim2.new(0, 42 + 21, 0, 42)
UniBoxButton.BorderSizePixel = 0
UniBoxButton.BackgroundTransparency = 1
UniBoxButton.Text = ""
UniBoxButton.SizeConstraint = Enum.SizeConstraint.RelativeXY
UniBoxButton.Parent = UniButton

SsamachiLibrary.UniButton = UniButton

function SsamachiLibrary:Destroy()
	Ssamachi:Destroy()
	FieldScreen:Destroy()
	
	if KeyMainUI then
		KeyMainUI:Destroy()
	end
	
	if KeyUI then
		KeyUI:Destroy()
	end
end

UniButtonClicked = function(Name, InputState, InputObject)
	if Debounce then
		return
	end
	
	if Hidden then
		Hidden = false
		Unhide()
	else
		if not SearchHided then
			Spawn(CloseSearch)
		end
		
		Hidden = true
		Hide()
	end
end

UniBoxButton.MouseButton1Click:Connect(UniButtonClicked)

UserInputService.InputBegan:Connect(function(Input, Processed)
	if (Input.KeyCode == Enum.KeyCode.RightShift and not Processed) then
		if Debounce then
			return
		end
		
		if Hidden then
			Hidden = false
			Unhide()
		else
			if not SearchHided then
				Spawn(CloseSearch)
			end
			
			Hidden = true
			Hide()
		end
	end
end)

for _, TopbarButton in ipairs(Topbar:GetChildren()) do
	if TopbarButton.ClassName == "ImageButton" then
		TopbarButton.MouseEnter:Connect(function()
			if TopbarButton.Name ~= 'Type' then
				TweenService:Create(TopbarButton, TweenInfo.new(0.7, Enum.EasingStyle.Quint), {ImageTransparency = 0}):Play()
			else
				TweenService:Create(TopbarButton, TweenInfo.new(0.7, Enum.EasingStyle.Quint), {ImageTransparency = 0.2}):Play()
			end
		end)
		
		TopbarButton.MouseLeave:Connect(function()
			if TopbarButton.Name ~= 'Type' then
				TweenService:Create(TopbarButton, TweenInfo.new(0.7, Enum.EasingStyle.Quint), {ImageTransparency = 0.8}):Play()
			else
				TweenService:Create(TopbarButton, TweenInfo.new(0.7, Enum.EasingStyle.Quint), {ImageTransparency = 0}):Play()
			end
		end)

		TopbarButton.MouseButton1Click:Connect(function()
			TweenService:Create(TopbarButton, TweenInfo.new(0.7, Enum.EasingStyle.Quint), {ImageTransparency = 0.8}):Play()
		end)
	end
end

function SsamachiLibrary:LoadConfiguration()
	if CEnabled then
		pcall(function()
			if isfile(ConfigurationFolder .. "/" .. CFileName .. ConfigurationExtension) then
				LoadConfiguration(readfile(ConfigurationFolder .. "/" .. CFileName .. ConfigurationExtension))
			end
		end)
	end
end

task.delay(9, SsamachiLibrary.LoadConfiguration, SsamachiLibrary)

return SsamachiLibrary
