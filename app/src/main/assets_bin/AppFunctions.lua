--此文件内为此页面的部分函数


MyFullDraggableContainer={
  _baseClass=FullDraggableContainer,
  __call=function(self,context)
    local view,initialMotionX
    view=luajava.override(FullDraggableContainer,{
      onInterceptTouchEvent=function(super,event)
        super(event)
        return false
        --super(event)
        --view.onTouchEvent(event)
      end
    },context)
    return view
  end,
}
setmetatable(MyFullDraggableContainer,MyFullDraggableContainer)



--检查是不是路径相同的文件
function isSamePathFileByPath(filePath1,filePath2)--通过文件路径
  return string.lower(filePath1)==string.lower(filePath2)
end
function isSamePathFile(file1,file2)--通过文件本身
  return isSamePathFileByPath(file1.getPath(),file2.getPath())
end

---在 v5.1.1(51199) 返回结果改为 normalTable
function createVirtualClass(normalTable)
  local metatable={
    __index=function(self,key)
      if rawget(self,key) then
        return rawget(self,key)
       else
        local getter="get"..key:gsub("^%l",string.upper)
        if rawget(self,getter) then
          return rawget(self,getter)()
        end
      end
    end
  }
  setmetatable(normalTable,metatable)
  return normalTable
end

function runLuaFile(file,code)
  if file and file.isFile() then
    newActivity(file.getPath())
   else
    newSubActivity("RunCode",{code})
  end
end

--自动识别显示toast的方式进行显示
function showSnackBar(text)
  if FilesBrowserManager.openState and nowDevice ~= "pc" then
    return MyToast(text,mainLay)
   else
    return MyToast(text,editorGroup)
  end
end

function isBinaryFile(filePath)
  local ioFile = io.open(filePath, "r")
  if ioFile then
    local code=ioFile:read("*all")
    ioFile:close()
    if code~="" then
      local c=string.byte(code)
      if c <= 0x1c and c>= 0x1a and c~=" " and c~="\t" then
        return true
      end
    end
    return code
   else
    return nil
  end
end

function safeCloneTable(oldTable,newTable)
  for index,content in pairs(oldTable) do
    if newTable[index]==nil then
      newTable[index]=oldTable[index]
    end
  end
end

--刷新Menu状态
function refreshMenusState()
  if LoadedMenu then
    local fileOpenState,projectOpenState=FilesTabManager.openState,ProjectManager.openState
    local isEditor=EditorsManager.checkEditorSupport("getText")
    local menus={
      {StateByFileMenus,fileOpenState},
      {StateByProjectMenus,projectOpenState},
      {StateByFileAndEditorMenus,fileOpenState and isEditor},
      {StateByEditorMenus,isEditor},
      {StateByNotBadPrjMenus,not(projectOpenState and ProjectManager.nowConfig.badPrj)}
    }
    for index,content in pairs(menus)do
      for index,menu in ipairs(content[1]) do
        menu.setEnabled(toboolean(content[2]))
      end
    end
    PluginsUtil.callElevents("refreshMenusState")
  end
end

---在 v5.1.0(51099) 已废除
function refreshMagnifier()
  print("警告","refreshMagnifier","在 v5.1.0(51099) 已废除")
end


local MyMimeMap={
  lua="text/plain",
}
setmetatable(MyMimeMap,{__index=function(self,key)
    return MimeTypeMap.getSingleton().getMimeTypeFromExtension(key) or "*/"
end})

--在 v5.1.0(51099) 添加
function getMimeType(extensionName)
  return MyMimeMap[extensionName]
end

--用外部应用打开文件
function openFileITPS(path)
  import "android.webkit.MimeTypeMap"
  local file=File(path)
  local name=file.getName()
  local extensionName=getFileTypeByName(name)
  local mime=getMimeType(extensionName)
  if mime then
    local intent=Intent()
    intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
    intent.setAction(Intent.ACTION_VIEW)
    intent.setType(mime)
    intent.setFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION)
    --intent.putExtra(Intent.EXTRA_STREAM, activity.getUriForFile(file))
    --intent.addFlags(Intent.FLAG_ACTIVITY_NEW_DOCUMENT)
    intent.setData(activity.getUriForFile(file))
    if mime=="*/" then
      activity.startActivity(Intent.createChooser(intent,name))
     else
      activity.startActivity(intent)
    end
  end
end

WindmillTools={
  手册=2,
  ["Java API"]=3,
  ["Http 调试"]=4,
}

function startWindmillActivity(toolName)
  local success=pcall(function()
    local uri = Uri.parse("wm://tool:"..WindmillTools[toolName])
    local intent = Intent(Intent.ACTION_VIEW, uri)
    intent.addFlags(Intent.FLAG_ACTIVITY_NEW_DOCUMENT)
    activity.startActivity(intent)
  end)
  if not(success) then
    openUrl("https://www.coolapk.com/apk/com.agyer.windmill")
  end
end

--公共Activity
local sharedActivityPathTemplate=AppPath.Sdcard.."/Android/media/%s/cache/temp/aidelua/activities/%s"

--更新共享Activity到目录
function updateSharedActivity(name,sdActivityDir)
  LuaUtil.rmDir(sdActivityDir)
  LuaUtil.copyDir(File(activity.getLuaDir("sub/"..name)),sdActivityDir)
end

function checkSharedActivity(name)
  local packageName
  packageName=ProjectManager.openState and ProjectManager.nowConfig.packageName or activity.getPackageName()
  local sdActivityPath=sharedActivityPathTemplate:format(packageName,name)--AppPath.AppShareCacheDir.."/activities/"..name
  local sdActivityDir=File(sdActivityPath)

  local sdActivityInitPath=sdActivityPath.."/init.lua"
  local sdActivityInitFile=File(sdActivityInitPath)
  local initExists=sdActivityInitFile.isFile()--主页面是否存在
  if initExists then
    local latestConfig=getConfigFromFile(activity.getLuaDir("sub/"..name.."/init.lua"))
    local success,nowConfig=pcall(getConfigFromFile,sdActivityInitPath)
    if not(success and nowConfig.appcode and latestConfig.appcode) or tonumber(latestConfig.appcode)~=tonumber(nowConfig.appcode) then
      updateSharedActivity(name,sdActivityDir)
    end
   else
    updateSharedActivity(name,sdActivityDir)
  end
  return sdActivityPath.."/main.lua"
end

function refreshSubTitle(newScreenWidthDp)
  if ProjectManager.openState then
    local appName=ProjectManager.nowConfig.appName
    if screenWidthDp then
      if screenWidthDp<360 then
        actionBar.setSubtitle(appName)
       elseif screenWidthDp<380 then
        actionBar.setSubtitle(formatResStr(R.string.project_appSubtitle_360dp,{appName}))
       elseif screenWidthDp<390 then
        actionBar.setSubtitle(formatResStr(R.string.project_appSubtitle_380dp,{appName}))
       else
        actionBar.setSubtitle(formatResStr(R.string.project_appSubtitle_390dp,{appName}))
      end
     else
      actionBar.setSubtitle(appName)
    end
    activity.setTaskDescription(ActivityManager.TaskDescription(appName.."-"..getString(R.string.app_name),nil,theme.color.colorPrimary))
   else
    actionBar.setSubtitle(R.string.project_no_open)
    activity.setTaskDescription(ActivityManager.TaskDescription(getString(R.string.app_name),nil,theme.color.colorPrimary))
  end
end

--啊这，扩展名写成类型了，就这样凑合用吧
function getFileTypeByName(name)
  local extensions=name:match(".+%.(.+)")
  if extensions then
    return string.lower(extensions)
  end
end

--修复因LayoutTransition导致的布局延迟
--修复逻辑：先去除LayoutTransition，再设置回来
--[[使用方法：
local applyLT=fixLT({view1,view2})
applyLT()
]]
function fixLT(list)
  local lTList={}
  for index=1,#list do
    local view=list[index]
    lTList[index]=view.getLayoutTransition()
    view.setLayoutTransition(nil)
  end
  return function()
    for index=1,#list do
      list[index].setLayoutTransition(lTList[index])
    end
    list=nil
    lTList=nil
  end
end

function addStrToTable(text,list,checkList)
  if not(checkList[text]) then
    table.insert(list,text)
    checkList[text]=true
  end
end

function getFilePathCopyMenus(inLibDirPath,filePath,fileRelativePath,fileName,isFile,isResDir,fileType)
  local textList={}
  local textCheckList={}
  if inLibDirPath then
    local callLibPath=inLibDirPath:gsub("/",".")
    addStrToTable(fileName:match("(.+)%.") or fileName,textList,textCheckList)
    addStrToTable(callLibPath,textList,textCheckList)
    if fileType=="aly" or fileType=="lua" or fileType=="java" or fileType=="kt" or File(filePath.."/init.lua").isFile() then
      addStrToTable(CodeHelper.getImportCode(callLibPath),textList,textCheckList)
    end
   else
    addStrToTable(fileName,textList,textCheckList)
  end
  addStrToTable(fileRelativePath,textList,textCheckList)
  --table.clear(textCheckList)
  textCheckList=nil
  return textList
end

--这是去除./和../的
function fixPath(path)
  path=(path.."/")
  :gsub("//+","/")
  :gsub("/%./","/")
  repeat
    local oldPath=path
    path=oldPath:gsub("/[^/]+/%.%./","/",1)
  until(oldPath==path)
  return path:match("(.+)/") or "/"
end

--获取table的index列表
function getTableIndexList(mTable)
  local list={}
  for index,content in pairs(mTable) do
    table.insert(list,index)
  end
  return list
end

local name2ColorMap={
  white=0xffffffff,
  black=0xff000000,
  red=0xffff0000,
  green=0xff00ff00,
  blue=0xff0000ff,
}
name2ColorMap.白色=name2ColorMap.white
name2ColorMap.黑色=name2ColorMap.black
name2ColorMap.红色=name2ColorMap.red
name2ColorMap.绿色=name2ColorMap.green
name2ColorMap.蓝色=name2ColorMap.blue
name2ColorMap.白=name2ColorMap.white
name2ColorMap.黑=name2ColorMap.black
name2ColorMap.红=name2ColorMap.white
name2ColorMap.绿=name2ColorMap.green
name2ColorMap.蓝=name2ColorMap.blue

function formatColor2Hex(color)
  if color>=0 and color<=0xFFFFFFFF then
    local success,result=pcall(String.format,"%08X", {color})
    if success then
      return "#"..result
    end
  end
end

--获取文字内颜色的数值和16进制
function getColorAndHex(text)
  if text and text~="" then
    local success,color
    color=name2ColorMap[string.lower(text)] or tonumber(text)
    if color then
      return color,formatColor2Hex(color)
    end
    success,color=pcall(Color.parseColor,"#"..text)
    if success then
      return color,"#"..string.upper(text)
    end
  end
end

---在 v5.1.1(51199) 添加
---适配SEND应用权限，适配华为文件管理
---@param uri Uri
function authorizeHWApplicationPermissions(uri)
  local flag=Intent.FLAG_GRANT_WRITE_URI_PERMISSION | Intent.FLAG_GRANT_READ_URI_PERMISSION
  local intent = Intent()
  intent.setAction("android.intent.action.SEND")
  intent.setFlags(268435456)
  intent.setType(activity.getContentResolver().getType(uri))
  local infoList=activity.getPackageManager().queryIntentActivities(intent, 65536)
  for index=0,#infoList-1 do
    activity.grantUriPermission(infoList[index].activityInfo.packageName, uri, flag)
  end
  activity.grantUriPermission("com.huawei.desktop.explorer", uri, flag)
  activity.grantUriPermission("com.huawei.desktop.systemui", uri, flag)
end

---v5.1.1+
function safeLoadLayout(path,parent)
  local env={}
  setmetatable(env,{__index=function(self,key)
      local globalVar=rawget(_G,key)
      if globalVar then
        rawset(self,key,globalVar)
        return globalVar
      end
      for index=1,#androidx do
        local classStr=androidx[index]:gsub("%*",key)
        local success,content=pcall(luajava.bindClass,classStr)
        if success then
          rawset(self,key,content)
          return content
        end
      end
  end})
  local file=io.open(path)
  local fileContent=file:read("*a")
  file:close()
  local layout=assert(loadstring("return "..fileContent,nil,"bt",env))()
  return loadlayout(layout,{},parent)
end

--v5.1.1+
function copyFilesFromDocumentFile(documentFile,targetPath)
  import "com.jesse205.util.FileInfoUtils"
  local uri=documentFile.getUri()
  local name=documentFile.getName()
  local newPath=targetPath.."/"..name
  if documentFile.isDirectory() then
    local isGetPathSucceeded,reallyPath=pcall(FileInfoUtils.getPath,activity,uri)
    if isGetPathSucceeded then
      local isCpSucceeded,content=pcall(FileUtil.copyDir, File(reallyPath), File(newPath))
      if not isCpSucceeded then
        showErrorDialog(name,content)
      end
    end
    --[[
    local list=documentFile.listFiles()
    for index=0,#list-1 do
      local name=documentFile.getName()
      copyFilesFromDocumentFile(documentFile,targetPath.."/"..name)
    end]]
   else
    if File(newPath).exists() then
      showSnackBar(name..": "..getString(R.string.file_exists))
     else
      local isOpenSuccessful,inputStream=pcall(activity.getContentResolver().openInputStream,uri)
      if not isOpenSuccessful then
        showErrorDialog("Unable to open uri",inputStream)
        return
      end
      local outStream=FileOutputStream(newPath)
      --LuaUtil.copyFile(inputStream, outStream)
      local success,content=pcall(FileUtil.copyFileStream,inputStream, outStream)
      if not success then
        showErrorDialog(name,content)
      end
      inputStream.close()
      outStream.close()
    end
  end
end

---v5.1.1+
---在Termux内运行代码
function runInTermux(cmd,args,config)
  if PermissionUtil.checkPermission("com.termux.permission.RUN_COMMAND") then
    if cmd:sub(1,1)~="/" then
      cmd="/data/data/com.termux/files/usr/bin/"..cmd
    end
    config=config or {}
    local intent=Intent()
    intent.setClassName(TermuxConstants.TERMUX_PACKAGE_NAME, TermuxConstants.TERMUX_APP.RUN_COMMAND_SERVICE_NAME)
    intent.setAction(RUN_COMMAND_SERVICE.ACTION_RUN_COMMAND)
    intent.putExtra(RUN_COMMAND_SERVICE.EXTRA_COMMAND_PATH,cmd)
    intent.putExtra(RUN_COMMAND_SERVICE.EXTRA_ARGUMENTS,String(args))
    intent.putExtra(RUN_COMMAND_SERVICE.EXTRA_BACKGROUND, false)
    intent.putExtra(RUN_COMMAND_SERVICE.EXTRA_WORKDIR, config.workDir or ProjectManager.nowPath.."/"..ProjectManager.nowConfig.mainModuleName)
    --显示结果
    if config.showResult then
      local resultIntent=activity.buildNewActivityIntent(0,"sub/TermuxResult/main.lua",nil,true,0)
      resultIntent.putExtra("title",config.title)
      local pendingIntent = PendingIntent.getActivity(activity, 1, resultIntent, PendingIntent.FLAG_ONE_SHOT)
      intent.putExtra(RUN_COMMAND_SERVICE.EXTRA_PENDING_INTENT, pendingIntent)
    end
    if Build.VERSION.SDK_INT >= 26 then
      activity.startForegroundService(intent)
     else
      activity.startService(intent)
    end
    local manager = activity.getPackageManager()
    local intent = manager.getLaunchIntentForPackage(TermuxConstants.TERMUX_PACKAGE_NAME)
    activity.startActivity(intent)
  end
end

--v5.1.1+
function path2DocumentUri(path)
  if String(path).startsWith(AppPath.Sdcard) then
    local relativePath=string.sub(path,string.len(AppPath.Sdcard)+2):gsub("/","%%2f")
    return Uri.parse("content://com.android.externalstorage.documents/document/primary:"..relativePath)
  end
end
