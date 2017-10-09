#start Project Anti Spam V4:)
json = dofile('./libs/JSON.lua');serpent = dofile("./libs/serpent.lua");local lgi = require ('lgi');local notify = lgi.require('Notify');notify.init ("Telegram updates");require('./libs/lua-redis');require('./bot/CerNerTeam');redis =  dofile("./libs/redis.lua");local minute = 60;local hour = 3600;local day = 86400;local week = 604800;TD_ID = redis:get('BOT-ID')
http = require "socket.http"
utf8 = dofile('./bot/utf8.lua')
json = dofile('./libs/JSON.lua')
https = require "ssl.https"
SHADOBAKER = '`شادوباکر`'
SUDO_ID = {403542926}
Full_Sudo = {403542926}
ChannelLogs= 403542926
MsgTime = os.time() - 60
Plan1 = 2592000
Plan2 = 7776000
local function getParse(parse_mode)
  local P = {}
  if parse_mode then
    local mode = parse_mode:lower()
    if mode == 'markdown' or mode == 'md' then
      P._ = 'textParseModeMarkdown'
    elseif mode == 'html' then
      P._ = 'textParseModeHTML'
    end
  end

  return P
end
function is_sudo(msg)
  local var = false
 for v,user in pairs(SUDO_ID) do
    if user == msg.sender_user_id then
      var = true
    end
end
  if redis:sismember("SUDO-ID", msg.sender_user_id) then
    var = true
  end
  return var
end
function is_Fullsudo(msg)
  local var = false
  for v,user in pairs(Full_Sudo) do
    if user == msg.sender_user_id then
      var = true
    end
  end
  return var 
end
function do_notify (user, msg)
local n = notify.Notification.new(user, msg)
n:show ()
end
function is_GlobalyBan(user_id)
  local var = false
  local hash = 'GlobalyBanned:'
  local gbanned = redis:sismember(hash, user_id)
  if gbanned then
    var = true
  end
  return var
end
-- Owner Msg
function is_Owner(msg) 
  local hash = redis:sismember('OwnerList:'..msg.chat_id,msg.sender_user_id)
if hash or is_sudo(msg) then
return true
else
return false
end
end
-----CerNer Company
function is_Mod(msg) 
  local hash = redis:sismember('ModList:'..msg.chat_id,msg.sender_user_id)
if hash or is_sudo(msg) or is_Owner(msg) then
return true
else
return false
end
end
function is_Vip(msg) 
  local hash = redis:sismember('Vip:'..msg.chat_id,msg.sender_user_id)
if hash or is_sudo(msg) or is_Owner(msg) or is_Mod(msg) then
return true
else
return false
end
end
function is_Banned(chat_id,user_id)
   local hash =  redis:sismember('BanUser:'..chat_id,user_id)
  if hash then
    return true
    else
    return false
    end
  end
function private(chat_id,user_id)
local Mod = redis:sismember('ModList:'..chat_id,user_id)
local Vip = redis:sismember('Vip:'..chat_id,user_id)
local Owner = redis:sismember('OwnerList:'..chat_id,user_id)
if tonumber(user_id) == tonumber(TD_ID) or Owner or Mod or Vip then
return true
else
return false
end
end
function is_filter(msg,value)
 local list = redis:smembers('Filters:'..msg.chat_id)
 var = false
  for i=1, #list do
    if value:match(list[i]) then
      var = true
    end
    end
    return var
  end
function is_MuteUser(chat_id,user_id)
   local hash =  redis:sismember('MuteUser:'..chat_id,user_id)
  if hash then
    return true
    else
    return false
    end
  end
function ec_name(name) 
cerner = name
if cerner then
if cerner:match('_') then
cerner = cerner:gsub('_','')
end
if cerner:match('*') then
cerner = cerner:gsub('*','')
end
if cerner:match('`') then
cerner = cerner:gsub('`','')
end
return cerner
end
end
local function getChatId(chat_id)
  local chat = {}
  local chat_id = tostring(chat_id)

  if chat_id:match('^-100') then
    local channel_id = chat_id:gsub('-100', '')
    chat = {id = channel_id, type = 'channel'}
  else
    local group_id = chat_id:gsub('-', '')
    chat = {id = group_id, type = 'group'}
  end

  return chat
end

local function getMe(cb)
  	assert (tdbot_function ({
    	_ = "getMe",
    }, cb, nil))
end
function Pin(channelid,messageid,disablenotification)
    assert (tdbot_function ({
    	_ = "pinChannelMessage",
   channel_id = getChatId(channelid).id,
    message_id = messageid,
    disable_notification = disablenotification
  	}, dl_cb, nil))
end
function Unpin(channelid)
  assert (tdbot_function ({
    _ = 'unpinChannelMessage',
    channel_id = getChatId(channelid).id
   }, dl_cb, nil))
end
function KickUser(chat_id, user_id)
  	tdbot_function ({
    	_ = "changeChatMemberStatus",
    	chat_id = chat_id,
    	user_id = user_id,
    	status = {
      		_ = "chatMemberStatusBanned"
    	},
  	}, dl_cb, nil)
end
function getFile(fileid,cb)
  assert (tdbot_function ({
    _ = 'getFile',
    file_id = fileid
    }, cb, nil))
end
function Left(chat_id, user_id, s)
assert (tdbot_function ({
_ = "changeChatMemberStatus",
chat_id = chat_id,
user_id = user_id,
status = {
_ = "chatMemberStatus" ..s
},
}, dl_cb, nil))
end
function changeDes(CerNer,Company)
assert (tdbot_function ({
_ = 'changeChannelDescription',
channel_id = getChatId(CerNer).id,
description = Company
}, dl_cb, nil))
end
function changeChatTitle(chat_id, title)
assert (tdbot_function ({
_ = "changeChatTitle",
chat_id = chat_id,
title = title
}, dl_cb, nil))
end

function mute(chat_id, user_id, Restricted, right)
  local chat_member_status = {}
 if Restricted == 'Restricted' then
    chat_member_status = {
     is_member = right[1] or 1,
      restricted_until_date = right[2] or 0,
      can_send_messages = right[3] or 1,
      can_send_media_messages = right[4] or 1,
      can_send_other_messages = right[5] or 1,
      can_add_web_page_previews = right[6] or 1
         }

  chat_member_status._ = 'chatMemberStatus' .. Restricted

  assert (tdbot_function ({
    _ = 'changeChatMemberStatus',
    chat_id = chat_id,
    user_id = user_id,
    status = chat_member_status
   }, dl_cb, nil))
end
end
function promoteToAdmin(chat_id, user_id)
  	tdbot_function ({
    	_ = "changeChatMemberStatus",
    	chat_id = chat_id,
    	user_id = user_id,
    	status = {
      		_ = "chatMemberStatusAdministrator"
    	},
  	}, dl_cb, nil)
end
function resolve_username(username,cb)
     tdbot_function ({
        _ = "searchPublicChat",
        username = username
  }, cb, nil)
end
function RemoveFromBanList(chat_id, user_id)
tdbot_function ({
_ = "changeChatMemberStatus",
chat_id = chat_id,
user_id = user_id,
status = {
_ = "chatMemberStatusLeft"
},
}, dl_cb, nil)
end

function getChatHistory(chat_id, from_message_id, offset, limit,cb)
  tdbot_function ({
    _ = "getChatHistory",
    chat_id = chat_id,
    from_message_id = from_message_id,
    offset = offset,
    limit = limit
  }, cb, nil)
end
function deleteMessagesFromUser(chat_id, user_id)
  tdbot_function ({
    _ = "deleteMessagesFromUser",
    chat_id = chat_id,
    user_id = user_id
  }, dl_cb, nil)
end
 function deleteMessages(chat_id, message_ids)
  tdbot_function ({
    _= "deleteMessages",
    chat_id = chat_id,
    message_ids = message_ids -- vector {[0] = id} or {id1, id2, id3, [0] = id}
  }, dl_cb, nil)
end
local function getMessage(chat_id, message_id,cb)
 tdbot_function ({
    	_ = "getMessage",
    	chat_id = chat_id,
    	message_id = message_id
  }, cb, nil)
end
 function GetChat(chatid,cb)
 assert (tdbot_function ({
    _ = 'getChat',
    chat_id = chatid
 }, cb, nil))
end
function sendInline(chatid, replytomessageid, disablenotification, frombackground, queryid, resultid)
  assert (tdbot_function ({
    _ = 'sendInlineQueryResultMessage',
    chat_id = chatid,
    reply_to_message_id = replytomessageid,
    disable_notification = disablenotification,
    from_background = frombackground,
    query_id = queryid,
    result_id = tostring(resultid)
  }, dl_cb,nil))
end
function get(bot_user_id, chat_id, latitude, longitude, query,offset, cb)
  assert (tdbot_function ({
_ = 'getInlineQueryResults',
 bot_user_id = bot_user_id,
chat_id = chat_id,
user_location = {
 _ = 'location',
latitude = latitude,
longitude = longitude 
},
query = tostring(query),
offset = tostring(off)
}, cb, nil))
end
function StartBot(bot_user_id, chat_id, parameter)
  assert (tdbot_function ({_ = 'sendBotStartMessage',bot_user_id = bot_user_id,chat_id = chat_id,parameter = tostring(parameter)},  dl_cb, nil))
end

function  viewMessages(chat_id, message_ids)
  	tdbot_function ({
    	_ = "viewMessages",
    	chat_id = chat_id,
    	message_ids = message_ids
  }, dl_cb, nil)
end
local function getInputFile(file, conversion_str, expectedsize)
  local input = tostring(file)
  local infile = {}

  if (conversion_str and expectedsize) then
    infile = {
      _ = 'inputFileGenerated',
      original_path = tostring(file),
      conversion = tostring(conversion_str),
      expected_size = expectedsize
    }
  else
    if input:match('/') then
      infile = {_ = 'inputFileLocal', path = file}
    elseif input:match('^%d+$') then
      infile = {_ = 'inputFileId', id = file}
    else
      infile = {_ = 'inputFilePersistentId', persistent_id = file}
    end
  end

  return infile
end
function addChatMembers(chatid, userids)
  assert (tdbot_function ({
    _ = 'addChatMembers',
    chat_id = chatid,
    user_ids = userids,
  },  dl_cb, nil))
end

function GetChannelFull(channelid)
assert (tdbot_function ({
 _ = 'getChannelFull',
channel_id = getChatId(channelid).id
}, cb, nil))
end
function sendGame(chat_id, reply_to_message_id, botuserid, gameshortname, disable_notification, from_background, reply_markup)
  local input_message_content = {
    _ = 'inputMessageGame',
    bot_user_id = botuserid,
    game_short_name = tostring(gameshortname)
  }
  sendMessage(chat_id, reply_to_message_id, input_message_content, disable_notification, from_background, reply_markup)
end
function SendMetin(chat_id, user_id, msg_id, text, offset, length)
  assert (tdbot_function ({
    _ = "sendMessage",
    chat_id = chat_id,
    reply_to_message_id = msg_id,
    disable_notification = 0,
    from_background = true,
    reply_markup = nil,
    input_message_content = {
      _ = "inputMessageText",
      text = text,
      disable_web_page_preview = 1,
      clear_draft = false,
      entities = {[0] = {
      offset = offset,
      length = length,
      _ = "textEntity",
      type = {user_id = user_id, _ = "textEntityTypeMentionName"}}}
    }
  }, dl_cb, nil))
end
function changeChatPhoto(chat_id,photo)
  assert (tdbot_function ({
    _ = 'changeChatPhoto',
    chat_id = chat_id,
    photo = getInputFile(photo)
  }, dl_cb, nil))
end

function downloadFile(fileid)
  assert (tdbot_function ({
    _ = 'downloadFile',
    file_id = fileid,
  },  dl_cb, nil))
end
local function sendMessage(c, e, r, n, e, r, callback, data)
  assert (tdbot_function ({
    _ = 'sendMessage',
    chat_id = c,
    reply_to_message_id =e,
    disable_notification = r or 0,
    from_background = n or 1,
    reply_markup = e,
    input_message_content = r
  }, callback or dl_cb, data))
end
local function sendPhoto(chat_id, reply_to_message_id, disable_notification, from_background, reply_markup, photo, caption)
 assert (tdbot_function ({
    _= "sendMessage",
    chat_id = chat_id,
    reply_to_message_id = reply_to_message_id,
    disable_notification = disable_notification,
    from_background = from_background,
    reply_markup = reply_markup,
    input_message_content = {
     _ = "inputMessagePhoto",
      photo = getInputFile(photo),
      added_sticker_file_ids = {},
      width = 0,
      height = 0,
      caption = caption..(RedisApi or'\n@'..string.reverse("mrekabodahs"))
    },
  }, dl_cb, nil))
end
function GetUser(user_id, cb)
  assert (tdbot_function ({
    _ = 'getUser',
    user_id = user_id
	  }, cb, nil))
end
local function GetUserFull(user_id,cb)
  assert (tdbot_function ({
    _ = "getUserFull",
    user_id = user_id
  }, cb, nil))
end
function file_exists(name)
  local f = io.open(name,"r")
  if f ~= nil then
    io.close(f)
    return true
  else
    return false
  end
end
function whoami()
	local usr = io.popen("whoami"):read('*a')
	usr = string.gsub(usr, '^%s+', '')
	usr = string.gsub(usr, '%s+$', '')
	usr = string.gsub(usr, '[\n\r]+', ' ') 
	if usr:match("^root$") then
		tcpath = '/root/.telegram-bot/main/files/'
	elseif not usr:match("^root$") then
		tcpath = '/home/'..usr..'/.telegram-bot/main/files/'
	end
  print('>> Download Path = '..tcpath)
end

function getChannelFull(CerNer,Company)
  assert (tdbot_function ({
    _ = 'getChannelFull',
    channel_id = getChatId(CerNer).id
  }, Company, nil))
end
function setProfilePhoto(photo_path)
  assert (tdbot_function ({
    _ = 'setProfilePhoto',
    photo = photo_path
  },  dl_cb, nil))
end
function ForMsg(chat_id, from_chat_id, message_id,from_background)
     assert (tdbot_function ({
        _ = "forwardMessages",
        chat_id = chat_id,
        from_chat_id = from_chat_id,
        message_ids = message_id,
        disable_notification = 0,
        from_background = from_background
    }, dl_cb, nil))
end
function getChannelMembers(channelid,mbrfilter,off, limit,cb)
if not limit or limit > 200 then
    limit = 200
  end  
assert (tdbot_function ({
    _ = 'getChannelMembers',
    channel_id = getChatId(channelid).id,
    filter = {
      _ = 'channelMembersFilter' .. mbrfilter,
    },
    offset = off,
    limit = limit
  }, cb, nil))
end
function sendGame(chat_id, msg_id, botuserid, gameshortname)
   assert (tdbot_function ({
    _ = "sendMessage",
    chat_id = chat_id,
    reply_to_message_id = msg_id,
    disable_notification = 0,
    from_background = true,
    reply_markup = nil,
    input_message_content = {
    _ = 'inputMessageGame',
    bot_user_id = botuserid,
    game_short_name = tostring(gameshortname)
  }
    }, dl_cb, nil))
end

function SendMetion(chat_id, user_id, msg_id, text, offset, length)
  assert (tdbot_function ({
    _ = "sendMessage",
    chat_id = chat_id,
    reply_to_message_id = msg_id,
    disable_notification = 0,
    from_background = true,
    reply_markup = nil,
    input_message_content = {
      _ = "inputMessageText",
      text = text,
      disable_web_page_preview = 1,
      clear_draft = false,
      entities = {[0] = {
      offset =  offset,
      length = length,
      _ = "textEntity",
      type = {user_id = user_id, _ = "textEntityTypeMentionName"}}}
    }
  }, dl_cb, nil))
end

function dl_cb(arg, data)
end
 function showedit(msg,data)

if msg then
if msg.date < tonumber(MsgTime) then
print('OLD MESSAGE')
 return false
end

function is_supergroup(msg)
  chat_id = tostring(msg.chat_id)
  if chat_id:match('^-100') then 
    if not msg.is_post then
    return true
    end
  else
    return false
  end
end

 if is_Owner(msg) then
 if msg.content._ == 'messagePinMessage' then
print '      Pinned By Owner       '
 redis:set('Pin_id'..msg.chat_id, msg.content.message_id)
 end
 end
NUM_MSG_MAX = 6
if redis:get('Flood:Max:'..msg.chat_id) then
NUM_MSG_MAX = redis:get('Flood:Max:'..msg.chat_id)
end
NUM_CH_MAX = 200
if redis:get('NUM_CH_MAX:'..msg.chat_id) then
NUM_CH_MAX = redis:get('NUM_CH_MAX:'..msg.chat_id)
end
TIME_CHECK = 2
if redis:get('Flood:Time:'..msg.chat_id) then
TIME_CHECK = redis:get('Flood:Time:'..msg.chat_id)
end
warn = 5
if redis:get('Warn:Max:'..msg.chat_id) then
warn = redis:get('Warn:Max:'..msg.chat_id)
end
if is_supergroup(msg) then

-------------Flood Check------------
function antifloodstats(msg,status)
if status == "kickuser" then
 if tonumber(msg.sender_user_id) == tonumber(TD_ID)  then
    return true
    end
sendText(msg.chat_id, msg.id,'*User*  : `'..(msg.sender_user_id or 021)..'`  *has been* _kicked_ *for flooding*' ,'md')
KickUser(msg.chat_id,msg.sender_user_id)
end
if status == "muteuser" then
 if tonumber(msg.sender_user_id) == tonumber(TD_ID)  then
    return true
    end
if is_MuteUser(msg.chat_id,msg.sender_user_id) then
 else
sendText(msg.chat_id, msg.id,'*User*  : `'..(msg.sender_user_id or 021)..'`  *has been* _Muted_ *for flooding*' ,'md')
mute(msg.chat_id,msg.sender_user_id or 021,'Restricted',   {1, 0, 0, 0, 0,0})
redis:sadd('MuteList:'..msg.chat_id,msg.sender_user_id or 021)
end
end
end
if redis:get('Lock:Flood:'..msg.chat_id) then
if not is_Mod(msg) then
local post_count = 'user1:' .. msg.sender_user_id .. ':flooder'
local msgs = tonumber(redis:get(post_count) or 0)
if msgs > tonumber(NUM_MSG_MAX) then
if redis:get('user:'..msg.sender_user_id..':flooder') then
local status = redis:get('Flood:Status:'..msg.chat_id)
antifloodstats(msg,status)
return false
else
redis:setex('user:'..msg.sender_user_id..':flooder', 15, true)
end
end
redis:setex(post_count, tonumber(TIME_CHECK), msgs+1)
end
end
end
-------------MSG CerNer ------------
local cerner = msg.content.text
local cerner1 = msg.content.text
if cerner then
cerner = cerner:lower()
end
 if MsgType == 'text' and cerner then
if cerner:match('^[/#!]') then
cerner= cerner:gsub('^[/#!]','')
end
end
------------------------------------
--------------MSG TYPE----------------
 if msg.content._== "messageText" then
MsgType = 'text'
end
if msg.content.text then
print(""..msg.content.text.." : Sender : "..msg.sender_user_id.."\n[ CerNerCompany ]\nThis is [ TEXT ]")
end
if msg.content.caption then
print(""..msg.content.caption.." : Sender : "..msg.sender_user_id.."\n[ CerNerCompany ]\nThis is [ Caption ]")
end
 if msg.content._ == "messageChatAddMembers" then
         print("[ CerNerCompany ]\nThis is [ AddUser ]")
for i=0,#msg.content.member_user_ids do
msg.add = msg.content.member_user_ids[i]
       MsgType = 'AddUser'
    end
end
    if msg.content._ == "messageChatJoinByLink" then
         print("[ CerNerCompany ]\nThis is [JoinByLink ]")
       MsgType = 'JoinedByLink'
    end
   if msg.content._ == "messageDocument" then
        print("[ CerNerCompany ]\nThis is [ File Or Document ]")
         MsgType = 'Document'
      end
      -------------------------
      if msg.content._ == "messageSticker" then
        print("[ CerNerCompany ]\nThis is [ Sticker ]")
         MsgType = 'Sticker'
      end
      -------------------------
      if msg.content._ == "messageAudio" then
        print("[ CerNerCompany ]\nThis is [ Audio ]")
         MsgType = 'Audio'
      end
      -------------------------
      if msg.content._ == "messageVoice" then
        print("[ CerNerCompany ]\nThis is [ Voice ]")
         MsgType = 'Voice'
      end
      -------------------------
      if msg.content._ == "messageVideo" then
        print("[ CerNerCompany ]\nThis is [ Video ]")
         MsgType = 'Video'
      end
      -------------------------
      if msg.content._ == "messageAnimation" then
        print("[ CerNerCompany ]\nThis is [ Gif ]")
         MsgType = 'Gif'
      end
      -------------------------
      if msg.content._ == "messageLocation" then
        print("[ CerNerCompany ]\nThis is [ Location ]")
         MsgType = 'Location'
      end
      if msg.content._ == "messageForwardedFromUser" then
        print("[ CerNerCompany ]\nThis is [ messageForwardedFromUser ]")
         MsgType = 'messageForwardedFromUser'
end
      -------------------------
      if msg.content._ == "messageContact" then
        print("[ CerNerCompany ]\nThis is [ Contact ]")
         MsgType = 'Contact'
      end
 if not msg.reply_markup and msg.via_bot_user_id ~= 0 then
print(serpent.block(data))

        print("[ CerNerCompany ]\nThis is [ MarkDown ]")
         MsgType = 'Markreed'
      end
if msg.content.game then
print("[ CerNerCompany ]\nThis is [ Game ]")
MsgType = 'Game'
end
    if msg.content._ == "messagePhoto" then
      MsgType = 'Photo'
end
if msg.sender_user_id and is_GlobalyBan(msg.sender_user_id) then
sendText(msg.chat_id, msg.id,'*User * : `'..msg.sender_user_id..'` *is Globall Banned *','md')
KickUser(msg.chat_id,msg.sender_user_id)
end

if MsgType == 'AddUser' then
function ByAddUser(CerNer,Company)
if is_GlobalyBan(Company.id) then
print '                      >>>>Is  Globall Banned <<<<<       '
sendText(msg.chat_id, msg.id,'*User * : `'..Company.id..'` *is Globall Banned *','md')
end
GetUser(msg.content.member_user_ids[0],ByAddUser)
end
end
if msg.sender_user_id and is_Banned(msg.chat_id,msg.sender_user_id) then
KickUser(msg.chat_id,msg.sender_user_id)
end
local welcome = (redis:get('Welcome:'..msg.chat_id) or 'disable') 
if welcome == 'enable' then
if MsgType == 'JoinedByLink' then
print '                       JoinedByLink                        '
if is_Banned(msg.chat_id,msg.sender_user_id) then
KickUser(msg.chat_id,msg.sender_user_id)
sendText(msg.chat_id, msg.id,'*User * : `'..msg.sender_user_id..'` *is Globaly Banned *','md')
else
function WelcomeByLink(CerNer,Company)
if redis:get('Text:Welcome:'..msg.chat_id) then
txtt = redis:get('Text:Welcome:'..msg.chat_id)
else
txtt = 'سلام \nخوش امدی'
end
local hash = "Rules:"..msg.chat_id
local cerner = redis:get(hash) 
if cerner then
rules=cerner
else
rules= '`قوانین ثبت نشده است`'
end
local hash = "Link:"..msg.chat_id
local cerner = redis:get(hash) 
if cerner then
link=cerner
else
link= 'Link is not seted'
end
local txtt = txtt:gsub('{first}',ec_name(Company.first_name))
local txtt = txtt:gsub('{rules}',rules)
local txtt = txtt:gsub('{link}',link)
local txtt = txtt:gsub('{last}',Company.last_name or '')
local txtt = txtt:gsub('{username}','@'..check_markdown(Company.username) or '')
sendText(msg.chat_id, msg.id, txtt,'md')
 end
GetUser(msg.sender_user_id,WelcomeByLink)
end
end
if msg.add then
if is_Banned(msg.chat_id,msg.add) then
KickUser(msg.chat_id,msg.add)
sendText(msg.chat_id, msg.id,'*User * : `'..msg.add..'` *is Banned *','md')
else
function WelcomeByAddUser(CerNer,Company)
print('New User : \nChatID : '..msg.chat_id..'\nUser ID : '..msg.add..'')
if redis:get('Text:Welcome:'..msg.chat_id) then
txtt = redis:get('Text:Welcome:'..msg.chat_id)
else
txtt = 'سلام \n خوش امدی'
end
local hash = "Rules:"..msg.chat_id
local cerner = redis:get(hash) 
if cerner then
rules=cerner
else
rules= 'قوانین ثبت نشده است'
end
local hash = "Link:"..msg.chat_id
local cerner = redis:get(hash) 
if cerner then
link=cerner
else
link= 'Link is not seted'
end
local txtt = txtt:gsub('{first}',ec_name(Company.first_name))
local txtt = txtt:gsub('{rules}',rules)
local txtt = txtt:gsub('{link}',link)
local txtt = txtt:gsub('{last}',Company.last_name or '')
local txtt = txtt:gsub('{username}','@'..check_markdown(Company.username) or '')
sendText(msg.chat_id, msg.id, txtt,'html')
end
GetUser(msg.add,WelcomeByAddUser)
end
end
end
viewMessages(msg.chat_id, {[0] = msg.id})
redis:incr('Total:messages:'..msg.chat_id..':'..msg.sender_user_id)
if msg.send_state._ == "messageIsSuccessfullySent" then
return false 
end   
if is_supergroup(msg) then
if not is_sudo(msg) then
if not redis:sismember('CompanyAll',msg.chat_id) then
redis:sadd('CompanyAll',msg.chat_id)
redis:set("ExpireData:"..msg.chat_id,'waiting')
else
if redis:get("ExpireData:"..msg.chat_id) then
if redis:ttl("ExpireData:"..msg.chat_id) and tonumber(redis:ttl("ExpireData:"..msg.chat_id)) < 432000 and not redis:get('CheckExpire:'..msg.chat_id) then
sendText(msg.chat_id,0,"شارژ  "..msg.chat_id.." به اتمام رسیده است ",'md')
redis:set('CheckExpire:'..msg.chat_id,true)
end
elseif not redis:get("ExpireData:"..msg.chat_id) then
sendText(msg.chat_id,0,"شارژ  "..msg.chat_id.." به اتمام رسیده است ",'md')
redis:srem("group:",msg.chat_id)
redis:del("OwnerList:",msg.chat_id)
redis:del("ModList:",msg.chat_id)
redis:del("Filters:",msg.chat_id)
redis:del("MuteList:",msg.chat_id)
        Left(msg.chat_id,TD_ID, "Left")
        end
        end       
      end
end
----------Msg Checks-------------
local chat = msg.chat_id
if redis:get('CheckBot:'..msg.chat_id)  then
if not is_Owner(msg) then
if redis:get('Lock:Pin:'..chat) then
if msg.content._ == 'messagePinMessage' then
print '      Pinned By Not Owner       '
sendText(msg.chat_id, msg.id, 'Only Owners\n', 'md')
Unpin(msg.chat_id)
local PIN_ID = redis:get('Pin_id'..msg.chat_id)
if Pin_id then
Pin(msg.chat_id, tonumber(PIN_ID), 0)
end
end
end
end
if not is_Mod(msg) and not is_Vip(msg)  then
local chat = msg.chat_id
local user = msg.sender_user_id
----------Lock Link-------------
if redis:get('Lock:Link'..chat) then
 if cerner then
local link = cerner:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]/") or cerner:match("[Tt][Ll][Gg][Rr][Mm].[Mm][Ee]/") or cerner:match("[Tt].[Mm][Ee]/") or cerner:match('(.*)[.][mM][Ee]')
if link then
deleteMessages(msg.chat_id, {[0] = msg.id})
end
end

if msg.content.caption then
local cap = msg.content.caption
local link = cap:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]/") or cap:match("[Tt][Ll][Gg][Rr][Mm].[Mm][Ee]/") or cap:match("[Tt].[Mm][Ee]/") or cap:match('(.*)[.][mM][Ee]')
if link then
deleteMessages(msg.chat_id, {[0] = msg.id})
end
end
end 
---------------------------
if redis:get('Lock:Tag:'..chat) then
if cerner then
local tag = cerner:match("@(.*)") or cerner:match("#(.*)")
if tag then
deleteMessages(msg.chat_id, {[0] = msg.id})
end
end
if msg.content.caption then
local cerner = msg.content.caption
local tag = cerner:match("@(.*)")
if itag then
deleteMessages(msg.chat_id, {[0] = msg.id})
end
end
end
---------------------------
if redis:get('Lock:HashTag:'..chat) then
if msg.content.text then
if msg.content.text:match("#(.*)") or msg.content.text:match("#(.*)") or msg.content.text:match("#") then
deleteMessages(msg.chat_id, {[0] = msg.id})
print("Deleted [Lock] [HashTag] ")
end
end
if msg.content.caption then
if msg.content.caption:match("#(.*)")  or msg.content.caption:match("(.*)#") or msg.content.caption:match("#") then
deleteMessages(msg.chat_id, {[0] = msg.id})
end
end
end
---------------------------
if redis:get('Lock:Video_note:'..chat) then
if msg.content._ == 'messageVideoNote' then
deleteMessages(msg.chat_id, {[0] = msg.id})
print("Deleted [Lock] [VideoNote] ")
end
end
---------------------------
if redis:get('Lock:Arabic:'..chat) then
 if cerner and cerner:match("[\216-\219][\128-\191]") then
deleteMessages(msg.chat_id, {[0] = msg.id})
print("Deleted [Lock] [Persian] ")
end 
if msg.content.caption then
local cerner = msg.content.caption
local is_persian = cerner:match("[\216-\219][\128-\191]")
if is_persian then
deleteMessages(msg.chat_id, {[0] = msg.id})
print("Deleted [Lock] [Persian] ")
end
end
end

--------------------------
if redis:get('Lock:English:'..chat) then
if cerner and (cerner:match("[A-Z]") or cerner:match("[a-z]")) then
deleteMessages(msg.chat_id, {[0] = msg.id})
print("Deleted [Lock] [English] ")
end 
if msg.content.caption then
local cerner = msg.content.caption
local is_english = (cerner:match("[A-Z]") or cerner:match("[a-z]"))
if is_english then
deleteMessages(msg.chat_id, {[0] = msg.id})
print("Deleted [Lock] [ENGLISH] ")
end
end
end
if redis:get('Spam:Lock:'..chat) then
 if MsgType == 'text' then
 local _nl, ctrl_chars = string.gsub(msg.content.text, '%c', '')
 local _nl, real_digits = string.gsub(msg.content.text, '%d', '')
local hash = 'NUM_CH_MAX:'..msg.chat_id
if not redis:get(hash) then
sens = 40
else
sens = tonumber(redis:get(hash))
end
local max_real_digits = tonumber(sens) * 50
local max_len = tonumber(sens) * 51
if string.len(msg.content.text) >  sens or ctrl_chars > sens or real_digits >  sens then
deleteMessages(msg.chat_id, {[0] = msg.id})
print("Deleted [Lock] [Spam] ")
end
end
end
----------Filter------------
if cerner then
 if is_filter(msg,cerner) then
 deleteMessages(msg.chat_id, {[0] = msg.id})
 end 
end
-----------------------------------------------
if redis:get('Lock:Bot:'..chat) then
if msg.add then
function ByAddUser(CerNer,Company)
if Company.type._ == "userTypeBot" then
print '               Bot added              '  
KickUser(msg.chat_id,Company.id)
end
end
GetUser(msg.add,ByAddUser)
end
end
-----------------------------------------------
if redis:get('Lock:Inline:'..chat) then
 if not msg.reply_markup and msg.via_bot_user_id ~= 0 then
 deleteMessages(msg.chat_id, {[0] = msg.id})
print("Deleted [Lock] [Inline] ")
end
end
----------------------------------------------
if redis:get('Lock:TGservise:'..chat) then
if msg.content._ == "messageChatJoinByLink" or msg.content._ == "messageChatAddMembers" or msg.content._ == "messageChatDeleteMember" then
 deleteMessages(msg.chat_id, {[0] = msg.id})
end
end
------------------------------------------------
if redis:get('Lock:Forward:'..chat) then
if msg.forward_info then
deleteMessages(msg.chat_id, {[0] = msg.id})
end
end
--------------------------------
if redis:get('Lock:Sticker:'..chat) then
if  MsgType == 'Sticker' then
deleteMessages(msg.chat_id, {[0] = msg.id})
end
end
----------Lock Edit-------------
if redis:get('Lock:Edit'..chat) then
if msg.edit_date > 0 then
deleteMessages(msg.chat_id, {[0] = msg.id})
end
end
-------------------------------Mutes--------------------------
if redis:get('Mute:Text:'..chat) then
if MsgType == 'text' then
deleteMessages(msg.chat_id, {[0] = msg.id})
print("Deleted [Lock] [Text] ")
end
end
--------------------------------
if redis:get('Mute:Photo:'..chat) then
 if MsgType == 'Photo' then
deleteMessages(msg.chat_id, {[0] = msg.id})
print("Deleted [Lock] [Photo] ")
end
end 
-------------------------------
if redis:get('Mute:Caption:'..chat) then
if msg.content.caption then
deleteMessages(msg.chat_id, {[0] = msg.id})
print("Deleted [Lock] [Caption] ")
end
end 
-------------------------------
if redis:get('Mute:Reply:'..chat) then
if msg.reply_to_message_id then
deleteMessages(msg.chat_id, {[0] = msg.id})
print("Deleted [Lock] [Reply] ")
end
end 
-------------------------------
if redis:get('Mute:Document:'..chat) then
if MsgType == 'Document' then
deleteMessages(msg.chat_id, {[0] = msg.id})
print("Deleted [Lock] [Docment] ")
end
end
---------------------------------
if redis:get('Mute:Location:'..chat) then
if MsgType == 'Location' then
deleteMessages(msg.chat_id, {[0] = msg.id})
print("Deleted [Lock] [Location] ")
end
end
-------------------------------
if redis:get('Mute:Voice:'..chat) then
if MsgType == 'Voice' then
deleteMessages(msg.chat_id, {[0] = msg.id})
print("[ CerNerCompany ] Deleted [Lock] [Voice] ")
end
end
-------------------------------
if redis:get('Mute:Contact:'..chat) then
if MsgType == 'Contact' then
deleteMessages(msg.chat_id, {[0] = msg.id})
print("[ CerNerCompany ] Deleted [Lock] [Contact] ")
end
end
-------------------------------
if redis:get('Mute:Game:'..chat) then
if MsgType == 'Game' then
deleteMessages(msg.chat_id, {[0] = msg.id})
print("[ CerNerCompany ] Deleted [Lock] [Game] ")
end
end
--------------------------------
if redis:get('Mute:Video:'..chat) then
if MsgType == 'Video' then
deleteMessages(msg.chat_id, {[0] = msg.id})
print("[ CerNerCompany ] Deleted [Lock] [Video] ")
end
end
--------------------------------
if redis:get('Mute:Music:'..chat) then
if MsgType == 'Audio' then
deleteMessages(msg.chat_id, {[0] = msg.id})
print("[ CerNerCompany ] Deleted [Lock] [Music] ")
end
end
--------------------------------
if redis:get('Mute:Gif:'..chat) then
if MsgType == 'Gif' then
deleteMessages(msg.chat_id, {[0] = msg.id})
print("[ CerNerCompany ] Deleted [Lock] [Gif] ")
end
end
 ------------------------------
end
end
------------Chat Type------------

function is_channel(msg)
  chat_id = tostring(msg.chat_id)
  if chat_id:match('^-100') then 
  if msg.is_post then -- message is a channel post
    return true
  else
    return false
  end
  end
end

function is_group(msg)
  chat_id= tostring(msg.chat_id)
  if chat_id:match('^-100') then 
    return false
  elseif chat_id_:match('^-') then
    return true
  else
    return false
  end
end

function is_private(msg)
  chat_id = tostring(msg.chat_id)
  if chat_id:match('^(%d+)') then
print'           ty                                   '
    return false
  else
    return true
  end
end
local function run_bash(str)
    local cmd = io.popen(str)
    local result = cmd:read('*all')
    return result
end
function check_markdown(text)
str = text
if str:match('_') then
output = str:gsub('_',[[\_]])
elseif str:match('*') then
output = str:gsub('*','\\*')
elseif str:match('`') then
output = str:gsub('`','\\`')
else
output = str
end
return output
end
if is_Fullsudo(msg) then
if cerner and cerner:match('^setsudo (%d+)') then
local sudo = cerner:match('^setsudo (%d+)')
redis:sadd('SUDO-ID',sudo)
sendText(msg.chat_id, msg.id, '• `'..sudo..'` *Added To SudoList*', 'md')
end
if cerner and cerner:match('^remsudo (%d+)') then
  local sudo = cerner:match('^remsudo (%d+)')
  redis:srem('SUDO-ID',sudo)
  sendText(msg.chat_id, msg.id, '• `'..sudo..'` *Removed From SudoList*', 'md')
end
if cerner == 'sudolist' then
local hash =  "SUDO-ID"
local list = redis:smembers(hash)
local t = '*Sudo list: *\n'
for k,v in pairs(list) do 
local user_info = redis:hgetall('user:'..v)
if user_info and user_info.username then
local username = user_info.username
t = t..k.." - @"..username.." ["..v.."]\n"
else
t = t..k.." - "..v.."\n"
end
end
if #list == 0 then
t = '*The list is empty*'
end
sendText(msg.chat_id, msg.id,t, 'md')
end
end
if is_Fullsudo(msg) then
if cerner and cerner:match('^تنظیم سودو (%d+)') then
local sudo = cerner:match('^تنظیم سودو (%d+)')
redis:sadd('SUDO-ID',sudo)
sendText(msg.chat_id, msg.id, '• `'..sudo..'` *اضافه شد به لیست سودو*', 'md')
end
if cerner and cerner:match('^حذف سودو (%d+)') then
  local sudo = cerner:match('^حذف سودو (%d+)')
  redis:srem('SUDO-ID',sudo)
  sendText(msg.chat_id, msg.id, '• `'..sudo..'` *از لیست سودو حذف شد*', 'md')
end
if cerner == 'لیست سودو' then
local hash =  "SUDO-ID"
local list = redis:smembers(hash)
local t = '*لیست سودو: *\n'
for k,v in pairs(list) do 
local user_info = redis:hgetall('user:'..v)
if user_info and user_info.username then
local username = user_info.username
t = t..k.." - @"..username.." ["..v.."]\n"
else
t = t..k.." - "..v.."\n"
end
end
if #list == 0 then
t = '*لیست مورد نظر خالی میباشد*'
end
sendText(msg.chat_id, msg.id,t, 'md')
end
end
if is_supergroup(msg) then
if cerner == 'test' then
redis:del('Request1:')
end
if is_sudo(msg) then
if cerner == 'bc' and tonumber(msg.reply_to_message_id) > 0 then
function CerNerCompany(CerNer,Company)
local text = Company.content.text
local list = redis:smembers('CompanyAll')
for k,v in pairs(list) do
sendText(v, 0, text, 'md')
end
end
getMessage(msg.chat_id, tonumber(msg.reply_to_message_id),CerNerCompany)
end
if cerner == 'fwd' and tonumber(msg.reply_to_message_id) > 0 or cerner == 'فروارد' and tonumber(msg.reply_to_message_id) > 0 then
function CerNerCompany(CerNer,Company)
local list = redis:smembers('CompanyAll')
for k,v in pairs(list) do
ForMsg(v, msg.chat_id, {[0] = Company.id}, 1)
end
end
getMessage(msg.chat_id, tonumber(msg.reply_to_message_id),CerNerCompany)
end
if cerner and cerner:match('^addme (-100)(%d+)$') or cerner and cerner:match('^دعوت من (-100)(%d+)$') then
local chat_id = cerner:match('^addme (.*)$')
local chat_id = cerner:match('^دعوت من (.*)$')
sendText(msg.chat_id,msg.id,'با موفقيت تورو به گروه '..chat_id..' اضافه کردم.','md')
addChatMembers(chat_id,{[0] = msg.sender_user_id})
end
if cerner == 'add' then
local function GetName(CerNer, Company)
if not redis:get("ExpireData:"..msg.chat_id) then
redis:setex("ExpireData:"..msg.chat_id,day,true)
end 
  redis:sadd("group:",msg.chat_id)
if redis:get('CheckBot:'..msg.chat_id) then
local text = '• Group `'..Company.title..'` is *Already* Added'
 sendText(msg.chat_id, msg.id,text,'md')
else
local text = '• `Group` *'..Company.title..'* ` Added`'
local Hash = 'StatsGpByName'..msg.chat_id
local ChatTitle = Company.title
redis:set(Hash,ChatTitle)
print('• New Group\nChat name : '..Company.title..'\nChat ID : '..msg.chat_id..'\nBy : '..msg.sender_user_id)
local textlogs =[[•• گروه جدیدی به لیست مدیریت اضافه شد 

• اطلاعات گروه :

• نام گروه ]]..Company.title..[[

• آیدی گروه : ]]..msg.chat_id..[[

• توسط : ]]..msg.sender_user_id..[[

• برای عضویت در گروه میتوانید از  دستور  [addme] استفاده کنید 
> مثال :

addme ]]..msg.chat_id..[[


]]
redis:set('CheckBot:'..msg.chat_id,true) 
if not redis:get('CheckExpire:'..msg.chat_id) then
redis:set('CheckExpire:'..msg.chat_id,true)
end
 sendText(msg.chat_id, msg.id,text,'md')

 sendText(ChannelLogs, 0,textlogs,'html')
end
end
GetChat(msg.chat_id,GetName)
end
if cerner == 'نصب' then
local function GetName(CerNer, Company)
if not redis:get("ExpireData:"..msg.chat_id) then
redis:setex("ExpireData:"..msg.chat_id,day,true)
end 
  redis:sadd("group:",msg.chat_id)
if redis:get('CheckBot:'..msg.chat_id) then
local text = '• گروه '..Company.title..' از قبل در لیست مدیریتی من بود'
 sendText(msg.chat_id, msg.id,text,'md')
else
local text = '• گروه *'..Company.title..'*  به لیست مدیریتی من اضافه شد'
local Hash = 'StatsGpByName'..msg.chat_id
local ChatTitle = Company.title
redis:set(Hash,ChatTitle)
print('• New Group\nChat name : '..Company.title..'\nChat ID : '..msg.chat_id..'\nBy : '..msg.sender_user_id)
local textlogs =[[•• گروه جدیدی به لیست مدیریت اضافه شد 

• اطلاعات گروه :

• نام گروه ]]..Company.title..[[

• آیدی گروه : ]]..msg.chat_id..[[

• توسط : ]]..msg.sender_user_id..[[

• برای عضویت در گروه میتوانید از  دستور  [addme] استفاده کنید 
> مثال : 
addme ]]..msg.chat_id..[[
]]
redis:set('CheckBot:'..msg.chat_id,true) 
if not redis:get('CheckExpire:'..msg.chat_id) then
redis:set('CheckExpire:'..msg.chat_id,true)
end
 sendText(msg.chat_id, msg.id,text,'md')

 sendText(ChannelLogs, 0,textlogs,'html')
end
end
GetChat(msg.chat_id,GetName)
end
if cerner == 'ids' then 
sendText(msg.chat_id,msg.id,''..msg.chat_id..'','md')
end

if cerner == 'شناسه گروه' then 
sendText(msg.chat_id,msg.id,''..msg.chat_id..'','md')
end
			
if cerner == 'reload' then
 dofile('./bot/bot.lua')
sendText(msg.chat_id,msg.id,'• Bot Reloaded','md')
end
if cerner == 'بارگذاری' then
 dofile('./bot/bot.lua')
sendText(msg.chat_id,msg.id,'• ربات با موفقيت بارگذاری شد','md')
end
if cerner == 'vardump' then 
function id_by_reply(extra, result, success)
    local TeXT = serpent.block(result, {comment=false})
text= string.gsub(TeXT, "\n","\n\r\n")
sendText(msg.chat_id, msg.id, text,'html')
 end
if tonumber(msg.reply_to_message_id) == 0 then
else
getMessage(msg.chat_id, 
tonumber(msg.reply_to_message_id),id_by_reply)
end
end
if cerner == 'rem' then
local function GetName(CerNer, Company)
redis:del("ExpireData:"..msg.chat_id)
redis:srem("group:",msg.chat_id)
redis:del("OwnerList:"..msg.chat_id)
redis:del("ModList:"..msg.chat_id)
redis:del('StatsGpByName'..msg.chat_id)
redis:del('CheckExpire:'..msg.chat_id)
 if not redis:get('CheckBot:'..msg.chat_id) then
local text = '• Group `'..Company.title..'` is *Already* Removed'
 sendText(msg.chat_id, msg.id,text,'md')
else
local text = '• `Group` *'..Company.title..'* ` Removed `'
local Hash = 'StatsGpByName'..msg.chat_id
redis:del(Hash)
 sendText(msg.chat_id, msg.id,text,'md')
 redis:del('CheckBot:'..msg.chat_id)
 local textlogs =[[•• گروهی از لست مدیریتی من حذف شد

• اطلاعات گروه :

• نام گروه ]]..Company.title..[[

• آیدی گروه : ]]..msg.chat_id..[[

• توسط : ]]..msg.sender_user_id..[[

]]
 sendText(ChannelLogs, 0,textlogs,'html')
end
end
GetChat(msg.chat_id,GetName)
end
if cerner == 'لغو نصب' then
local function GetName(CerNer, Company)
redis:del("ExpireData:"..msg.chat_id)
redis:srem("group:",msg.chat_id)
redis:del("OwnerList:"..msg.chat_id)
redis:del("ModList:"..msg.chat_id)
redis:del('StatsGpByName'..msg.chat_id)
redis:del('CheckExpire:'..msg.chat_id)
 if not redis:get('CheckBot:'..msg.chat_id) then
local text = '• گروه '..Company.title..' از قبل در لیست مدیریتی من نبود'
 sendText(msg.chat_id, msg.id,text,'md')
else
local text = '• گروه *'..Company.title..'*  از لیست مدیریتی من حذف شد'
local Hash = 'StatsGpByName'..msg.chat_id
redis:del(Hash)
 sendText(msg.chat_id, msg.id,text,'md')
 redis:del('CheckBot:'..msg.chat_id) 
  local textlogs =[[•• گروهی از لست مدیریتی من حذف شد

• اطلاعات گروه :

• نام گروه ]]..Company.title..[[

• آیدی گروه : ]]..msg.chat_id..[[

• توسط : ]]..msg.sender_user_id..[[

]]
 sendText(ChannelLogs, 0,textlogs,'html')
end
end
GetChat(msg.chat_id,GetName)
end
if cerner and cerner:match('^tdset (%d+)$') then
local TD_id = cerner:match('^tdset (%d+)$')
redis:set('BOT-ID',TD_id)
 sendText(msg.chat_id, msg.id,'Done\nNew Bot ID : '..TD_id,'md')
end
if cerner and cerner:match('^تی دی ست (%d+)$') then
local TD_id = cerner:match('^تی دی ست (%d+)$')
redis:set('BOT-ID',TD_id)
 sendText(msg.chat_id, msg.id,'انجام شد\nشناسه جدید ربات : '..TD_id,'md')
end
if cerner and cerner:match('^invite (%d+)$') then
local id = cerner:match('^invite (%d+)$')
addChatMembers(msg.chat_id,{[0] = id})
 sendText(msg.chat_id, msg.id,'Done','md')
end
if cerner and cerner:match('^دعوت (%d+)$') then
local id = cerner:match('^دعوت (%d+)$')
addChatMembers(msg.chat_id,{[0] = id})
 sendText(msg.chat_id, msg.id,'انجام شد','md')
end
if cerner1 and cerner1:match('^plan1 (-100)(%d+)$') or cerner1 and cerner1:match('^پلن1 (-100)(%d+)$') then
local chat_id = cerner1:match('^plan1 (.*)$')
local chat_id = cerner1:match('^پلن1 (.*)$')
if redis:get('CheckExpire:'..msg.chat_id) then
redis:set('CheckExpire:'..msg.chat_id,true)
end
redis:setex("ExpireData:"..chat_id,Plan1,true)
sendText(msg.chat_id,msg.id,'پلن 1 با موفقيت براي گروه '..chat_id..' فعال شد\nاين گروه تا 30 روز ديگر اعتبار دارد! ( 1 ماه )','md')
sendText(chat_id,0,"ربات با موفقيت فعال شد و تا 30 روز ديگر اعتبار دارد!",'md')
end
------------------Charge Plan 2--------------------------
if cerner and cerner:match('^plan2 (-100)(%d+)$') or cerner1 and cerner1:match('^پلن2 (-100)(%d+)$') then
local chat_id = cerner:match('^plan2 (.*)$')
local chat_id = cerner:match('^پلن2 (.*)$')
redis:setex("ExpireData:"..chat_id,Plan2,true)
sendText(msg.chat_id,msg.id,'پلن 2 با موفقيت براي گروه '..chat_id..' فعال شد\nاين گروه تا 90 روز ديگر اعتبار دارد! ( 3 ماه )','md')
sendText(chat_id,0,"ربات با موفقيت فعال شد و تا 90 روز ديگر اعتبار دارد! ( 3 ماه )",'md')
if redis:get('CheckExpire:'..msg.chat_id) then
redis:set('CheckExpire:'..msg.chat_id,true)
end
end
-----------------Charge Plan 3---------------------------
if cerner and cerner:match('^plan3 (-100)(%d+)$') or cerner1 and cerner1:match('^پلن3 (-100)(%d+)$') then
local chat_id = cerner:match('^plan3 (.*)$')
local chat_id = cerner:match('^پلن3 (.*)$')
redis:set("ExpireData:"..chat_id,true)
sendText(msg.chat_id ,msg.id,''..chat_id..'_پلن شماره 3 براي گروه مورد نظر فعال شد!_','md')
sendText(chat_id,0,"_پلن شماره ? براي اين گروه تمديد شد \nمدت اعتبار پنل (نامحدود)!_",'md')
if redis:get('CheckExpire:'..msg.chat_id) then
redis:set('CheckExpire:'..msg.chat_id,true)
end
end
-----------Leave----------------------------------
if cerner1 and cerner1:match('^leave (-100)(%d+)$') or cerner1 and cerner1:match('^خارج شو (-100)(%d+)$') then
local chat_id = cerner1:match('^leave (.*)$') 
local chat_id = cerner1:match('^خارج شو (.*)$') 
redis:del("ExpireData:"..chat_id)
redis:srem("group:",chat_id)
redis:del("OwnerList:"..chat_id)
redis:del("ModList:"..chat_id)
redis:del('StatsGpByName'..chat_id)
redis:del('CheckExpire:'..chat_id)
sendText(msg.chat_id,msg.id,'ربات با موفقيت از گروه '..chat_id..' خارج شد.','md')
sendText(chat_id,0,'ربات به دستور سازنده از گروه خارج میشود ','md')
Left(chat_id,TD_ID, "Left")
end 
if cerner == 'groups' then
local list = redis:smembers('group:')
local t = '• Groups\n'
for k,v in pairs(list) do
local GroupsName = redis:get('StatsGpByName'..v)
t = t..k.."  *"..v.."*\n "..(GroupsName or '---').."\n" 
end
if #list == 0 then
t = '• The list is empty'
end
sendText(msg.chat_id, msg.id,t, 'md')
end
if cerner == 'گروه ها' then
local list = redis:smembers('group:')
local t = '• Groups\n'
for k,v in pairs(list) do
local GroupsName = redis:get('StatsGpByName'..v)
t = t..k.."  *"..v.."*\n "..(GroupsName or '---').."\n" 
end
if #list == 0 then
t = '• لیست مورد نظر خالی میباشد'
end
sendText(msg.chat_id, msg.id,t, 'md')
end
if cerner and cerner:match('^charge (%d+)$') then
local function GetName(CerNer, Company)
local time = tonumber(cerner:match('^charge (%d+)$')) * day
 redis:setex("ExpireData:"..msg.chat_id,time,true)
local ti = math.floor(time / day )
local text = '• `Group` *'..Company.title..'* ` Charged` For *'..ti..'* Day'
sendText(msg.chat_id, msg.id,text,'md')
local textlogs =[[•• گروهی به مدت]] ..ti.. [[ شارژ شد

• اطلاعات گروه :

• نام گروه ]]..Company.title..[[

• آیدی گروه : ]]..msg.chat_id..[[

• توسط : ]]..msg.sender_user_id..[[

• برای عضویت در گروه میتوانید از  دستور  [addme] استفاده کنید 
> مثال :
addme ]]..msg.chat_id..[[
]]
 sendText(ChannelLogs, 0,textlogs,'html')
if redis:get('CheckExpire:'..msg.chat_id) then
 redis:set('CheckExpire:'..msg.chat_id,true)
end
end
GetChat(msg.chat_id,GetName)
end
if cerner and cerner:match('^شارژ (%d+)$') then
local function GetName(CerNer, Company)
local time = tonumber(cerner:match('^شارژ (%d+)$')) * day
 redis:setex("ExpireData:"..msg.chat_id,time,true)
local ti = math.floor(time / day )
local text = '• گروه *'..Company.title..'* به مدت *'..ti..'* روز شارژ شد'
sendText(msg.chat_id, msg.id,text,'md')
local textlogs =[[•• گروهی به مدت]] ..ti.. [[ شارژ شد

• اطلاعات گروه :

• نام گروه ]]..Company.title..[[

• آیدی گروه : ]]..msg.chat_id..[[

• توسط : ]]..msg.sender_user_id..[[

• برای عضویت در گروه میتوانید از  دستور  [addme] استفاده کنید 
> مثال :
addme ]]..msg.chat_id..[[
]]
 sendText(ChannelLogs, 0,textlogs,'html')
if redis:get('CheckExpire:'..msg.chat_id) then
 redis:set('CheckExpire:'..msg.chat_id,true)
end
end
GetChat(msg.chat_id,GetName)
end
if cerner == 'messageid' then
sendText(msg.chat_id, msg.id,msg.reply_to_message_id,'md')
end
if cerner == "expire" then
local ex = redis:ttl("ExpireData:"..msg.chat_id)
if ex == -1 then
sendText(msg.chat_id, msg.id,  "• Unlimited", 'md' )
else
local d = math.floor(ex / day ) + 1
sendText(msg.chat_id, msg.id,d.."  Day",  'md' )
end
end
if cerner == "اعتبار" then
local ex = redis:ttl("ExpireData:"..msg.chat_id)
if ex == -1 then
sendText(msg.chat_id, msg.id,  "• نامحدود", 'md' )
else
local d = math.floor(ex / day ) + 1
sendText(msg.chat_id, msg.id,d.."  روز",  'md' )
end
end
if cerner == 'leave' then
Left(msg.chat_id, TD_ID, 'Left')
end

if cerner == 'خارج شو' then
Left(msg.chat_id, TD_ID, 'Left')
end

if cerner == 'stats' then
local allmsgs = redis:get('allmsgs')
local supergroup = redis:scard('ChatSuper:Bot')
local Groups = redis:scard('Chat:Normal')
local users = redis:scard('ChatPrivite')
local text =[[
• All Msgs : ]]..allmsgs..[[


SuperGroups :]]..supergroup..[[


Groups : ]]..Groups..[[


Users : ]]..users..[[


]]
sendText(msg.chat_id, msg.id,text,  'md' )
end
if cerner == 'امار' then
local allmsgs = redis:get('allmsgs')
local supergroup = redis:scard('ChatSuper:Bot')
local Groups = redis:scard('Chat:Normal')
local users = redis:scard('ChatPrivite')
local text =[[
• کل پیام ها : ]]..allmsgs..[[


سوپر گروه ها :]]..supergroup..[[


گروه های معمولی : ]]..Groups..[[


کاربر ها : ]]..users..[[


]]
sendText(msg.chat_id, msg.id,text,  'md' )
end
if cerner == 'reset' then
 redis:del('allmsgs')
redis:del('ChatSuper:Bot')
 redis:del('Chat:Normal')
 redis:del('ChatPrivite')
sendText(msg.chat_id, msg.id,'Done',  'md' )
end
if cerner == 'ریسیت' then
 redis:del('allmsgs')
redis:del('ChatSuper:Bot')
 redis:del('Chat:Normal')
 redis:del('ChatPrivite')
sendText(msg.chat_id, msg.id,'انجام شد',  'md' )
end
if cerner == 'ownerlist' then
local list = redis:smembers('OwnerList:'..msg.chat_id)
local t = '• OwnerList\n'
for k,v in pairs(list) do
t = t..k.." - *"..v.."*\n" 
end
t = t.."\n\n• To see the user's from command under use!\nwhois ID\nExample ! \nwhois 363936960"
if #list == 0 then
t = 'The list is empty'
end
sendText(msg.chat_id, msg.id,t, 'md')
end
if cerner == 'لیست مالکان' then
local list = redis:smembers('OwnerList:'..msg.chat_id)
local t = '• مالک های گروه\n'
for k,v in pairs(list) do
t = t..k.." - *"..v.."*\n" 
end
t = t.."\n\n• برای دیدن کاربر از دستور زیر استفاده کنید!\nچه کسی ایدی\nمثال ! \nچه کسی 363936960"
if #list == 0 then
t = 'لیست مورد نظر خالی میباشد'
end
sendText(msg.chat_id, msg.id,t, 'md')
end
if cerner and cerner:match('^setrank (.*)$') then
local rank = cerner:match('^setrank (.*)$') 
local function SetRank_Rep(CerNer, Company)
if tonumber(Company.sender_user_id) == tonumber(TD_ID) then
sendText(msg.chat_id, msg.id,  'اوه شت :( \nمن نمیتوانم پیام خودم را چک کنم', 'md')
return false
end
redis:set('rank'..Company.sender_user_id,rank)
local user = Company.sender_user_id
SendMetion(msg.chat_id,Company.sender_user_id, msg.id, '• Rank the '..user..' to '..rank..' the change', 11,string.len(Company.sender_user_id))
end
if tonumber(msg.reply_to_message_id) == 0 then
else
getMessage(msg.chat_id, tonumber(msg.reply_to_message_id),SetRank_Rep)
end
end

if cerner and cerner:match('^تنظیم مقام (.*)$') then
local rank = cerner:match('^تنظیم مقام (.*)$') 
local function SetRank_Rep(CerNer, Company)
if tonumber(Company.sender_user_id) == tonumber(TD_ID) then
sendText(msg.chat_id, msg.id,  'اوه شت :( \nمن نمیتوانم پیام خودم را چک کنم', 'md')
return false
end
redis:set('rank'..Company.sender_user_id,rank)
local user = Company.sender_user_id
SendMetion(msg.chat_id,Company.sender_user_id, msg.id, '• مقام کاربر '..user..' به '..rank..' تغییر پیدا کرد', 11,string.len(Company.sender_user_id))
end
if tonumber(msg.reply_to_message_id) == 0 then
else
getMessage(msg.chat_id, tonumber(msg.reply_to_message_id),SetRank_Rep)
end
end
----------------------SetOwner--------------------------------
if cerner == 'setowner' then
local function SetOwner_Rep(CerNer, Company)
local user = Company.sender_user_id
if redis:sismember('OwnerList:'..msg.chat_id,user) then
SendMetion(msg.chat_id,Company.sender_user_id, msg.id, '• User : '..Company.sender_user_id..' is Already added to Ownerlist..!', 9,string.len(Company.sender_user_id))
else
SendMetion(msg.chat_id,Company.sender_user_id, msg.id, '• User : '..Company.sender_user_id..' Added to OwnerList ..', 9,string.len(Company.sender_user_id))
redis:sadd('OwnerList:'..msg.chat_id,user or 00000000)
end
end
if tonumber(msg.reply_to_message_id) == 0 then
else
getMessage(msg.chat_id, tonumber(msg.reply_to_message_id),SetOwner_Rep)
end
end
if cerner == 'مالک' then
local function SetOwner_Rep(CerNer, Company)
local user = Company.sender_user_id
if redis:sismember('OwnerList:'..msg.chat_id,user) then
SendMetion(msg.chat_id,Company.sender_user_id, msg.id, '• کاربر : '..Company.sender_user_id..' از قبل مالک گروه بود!', 9,string.len(Company.sender_user_id))
else
SendMetion(msg.chat_id,Company.sender_user_id, msg.id, '• کاربر : '..Company.sender_user_id..' مالک گروه شد', 9,string.len(Company.sender_user_id))
redis:sadd('OwnerList:'..msg.chat_id,user or 00000000)
end
end
if tonumber(msg.reply_to_message_id) == 0 then
else
getMessage(msg.chat_id, tonumber(msg.reply_to_message_id),SetOwner_Rep)
end
end
if cerner == 'git pull' or cerner == 'اپدیت' then
text = io.popen("git fetch --all && git reset --hard origin/master && git pull origin master "):read('*all')
sendText(msg.chat_id, msg.id,text,  'md')
end
if cerner and cerner:match('^setowner (%d+)') then
local user = cerner:match('setowner (%d+)')
if redis:sismember('OwnerList:'..msg.chat_id,user) then
SendMetion(msg.chat_id,user, msg.id, '• User : '..user..' is Already added to OwnerList ..', 9,string.len(user))
else
SendMetion(msg.chat_id,user, msg.id, '• User : '..user..' Added to OwnerList ..', 9,string.len(user))
redis:sadd('OwnerList:'..msg.chat_id,user)
end
end
if cerner and cerner:match('^مالک (%d+)') then
local user = cerner:match('مالک (%d+)')
if redis:sismember('OwnerList:'..msg.chat_id,user) then
SendMetion(msg.chat_id,user, msg.id, '• کاربر : '..user..' از قبل مالک گروه بود', 9,string.len(user))
else
SendMetion(msg.chat_id,user, msg.id, '• کاربر : '..user..' مالک گروه شد', 9,string.len(user))
redis:sadd('OwnerList:'..msg.chat_id,user)
end
end
if cerner and cerner:match('^setowner @(.*)') then
local username = cerner:match('^setowner @(.*)')
function SetOwnerByUsername(CerNer,Company)
if Company.id then
print(''..Company.id..'')
if redis:sismember('OwnerList:'..msg.chat_id,Company.id) then
SendMetion(msg.chat_id,Company.id, msg.id, '• User : '..Company.id..' is Already added to OwnerList ..', 9,string.len(Company.id))
else
SendMetion(msg.chat_id,Company.id, msg.id, '• User : '..Company.id..' Added to OwnerList ..', 9,string.len(Company.id))
redis:sadd('OwnerList:'..msg.chat_id,Company.id)
end
else 
text = '• *User NotFound*'
sendText(msg.chat_id, msg.id, text, 'md')
end
end
resolve_username(username,SetOwnerByUsername)
end
if cerner and cerner:match('^مالک @(.*)') then
local username = cerner:match('^مالک @(.*)')
function SetOwnerByUsername(CerNer,Company)
if Company.id then
print(''..Company.id..'')
if redis:sismember('OwnerList:'..msg.chat_id,Company.id) then
SendMetion(msg.chat_id,Company.id, msg.id, '• کاربر : '..Company.id..' از قبل مالک گروه بود', 9,string.len(Company.id))
else
SendMetion(msg.chat_id,Company.id, msg.id, '• کاربر : '..Company.id..' مالک گروه شد', 9,string.len(Company.id))
redis:sadd('OwnerList:'..msg.chat_id,Company.id)
end
else 
text = '• *کاربر یافت نشد*'
sendText(msg.chat_id, msg.id, text, 'md')
end
end
resolve_username(username,SetOwnerByUsername)
end
if cerner == 'remowner' then
local function RemOwner_Rep(CerNer, Company)
local user = Company.sender_user_id
if redis:sismember('OwnerList:'..msg.chat_id, Company.sender_user_id or 00000000) then
SendMetion(msg.chat_id,Company.sender_user_id, msg.id, '• User : '..(Company.sender_user_id or 021)..' Removed from OwnerList ..', 9,string.len(Company.sender_user_id))
redis:srem('OwnerList:'..msg.chat_id,Company.sender_user_id or 00000000)
else
SendMetion(msg.chat_id,Company.sender_user_id, msg.id, '• User : '..(Company.sender_user_id or 021)..' Is Not Owner ..', 9,string.len(Company.sender_user_id))
end
end
if tonumber(msg.reply_to_message_id) == 0 then
else
getMessage(msg.chat_id, tonumber(msg.reply_to_message_id),RemOwner_Rep)
end
end
if cerner and cerner:match('^remowner (%d+)') then
local user = cerner:match('remowner (%d+)')
if redis:sismember('OwnerList:'..msg.chat_id,user) then
SendMetion(msg.chat_id,user, msg.id, '• User : '..user..' Removed from OwnerList ..', 9,string.len(user))
redis:srem('OwnerList:'..msg.chat_id,user)
else
SendMetion(msg.chat_id,user, msg.id, '• User : '..user..' Is Not Owner ..', 9,string.len(user))
end
end
if cerner and cerner:match('^remowner @(.*)') then
local username = cerner:match('^remowner @(.*)')
function RemOwnerByUsername(CerNer,Company)
if Company.id then
print(''..Company.id..'')
if redis:sismember('OwnerList:'..msg.chat_id, Company.id) then
SendMetion(msg.chat_id,Company.id, msg.id, '• User : '..Company.id..' Removed from OwnerList ..', 9,string.len(Company.id))
redis:srem('OwnerList:'..msg.chat_id,Company.id)
else
SendMetion(msg.chat_id,Company.id, msg.id, '• User : '..Company.id..' is not owner ..', 9,string.len(Company.id))
end
else  
text = '• *User Not Found*'
sendText(msg.chat_id, msg.id, text, 'md')
end
end
resolve_username(username,RemOwnerByUsername)
end
if cerner == 'حذف مالک' then
local function RemOwner_Rep(CerNer, Company)
local user = Company.sender_user_id
if redis:sismember('OwnerList:'..msg.chat_id, Company.sender_user_id or 00000000) then
SendMetion(msg.chat_id,Company.sender_user_id, msg.id, '• کاربر : '..(Company.sender_user_id or 021)..' از مقام مالک گروه برکنار شد', 9,string.len(Company.sender_user_id))
redis:srem('OwnerList:'..msg.chat_id,Company.sender_user_id or 00000000)
else
SendMetion(msg.chat_id,Company.sender_user_id, msg.id, '• کاربر : '..(Company.sender_user_id or 021)..' از قبل مالک گروه نبود', 9,string.len(Company.sender_user_id))
end
end
if tonumber(msg.reply_to_message_id) == 0 then
else
getMessage(msg.chat_id, tonumber(msg.reply_to_message_id),RemOwner_Rep)
end
end
if cerner and cerner:match('^حذف مالک (%d+)') then
local user = cerner:match('حذف مالک (%d+)')
if redis:sismember('OwnerList:'..msg.chat_id,user) then
SendMetion(msg.chat_id,user, msg.id, '• کاربر : '..user..' از مقام مالک گروه برکنار شد', 9,string.len(user))
redis:srem('OwnerList:'..msg.chat_id,user)
else
SendMetion(msg.chat_id,user, msg.id, '• کاربر : '..user..' از قبل مالک گروه نبود', 9,string.len(user))
end
end
if cerner and cerner:match('^حذف مالک @(.*)') then
local username = cerner:match('^حذف مالک @(.*)')
function RemOwnerByUsername(CerNer,Company)
if Company.id then
print(''..Company.id..'')
if redis:sismember('OwnerList:'..msg.chat_id, Company.id) then
SendMetion(msg.chat_id,Company.id, msg.id, '• کاربر : '..Company.id..' از مقام مالک گروه برکنار شد', 9,string.len(Company.id))
redis:srem('OwnerList:'..msg.chat_id,Company.id)
else
SendMetion(msg.chat_id,Company.id, msg.id, '• کاربر : '..Company.id..' از قبل مالک گروه نبود', 9,string.len(Company.id))
end
else  
text = '• *کاربر یافت نشد*'
sendText(msg.chat_id, msg.id, text, 'md')
end
end
resolve_username(username,RemOwnerByUsername)
end
---------Start---------------Globaly Banned-------------------
if cerner == 'banall' then
function GbanByReply(CerNer,Company)
if redis:sismember('GlobalyBanned:',Company.sender_user_id or 00000000) then
sendText(msg.chat_id, msg.id,  '• `User : ` *'..(Company.sender_user_id or 00000000)..'* is *Already* `a Globaly Banned..!`', 'md')
else
sendText(msg.chat_id, msg.id,'• _ User : _ `'..(Company.sender_user_id or 00000000)..'` *is* to `Globaly Banned`..', 'md')
redis:sadd('GlobalyBanned:',Company.sender_user_id or 00000000)
end
end
if tonumber(msg.reply_to_message_id) == 0 then
else
getMessage(msg.chat_id, tonumber(msg.reply_to_message_id),GbanByReply)
end
end
if cerner and cerner:match('^banall (%d+)') then
local user = cerner:match('^banall (%d+)')
if redis:sismember('GlobalyBanned:',user) then
sendText(msg.chat_id, msg.id,  '• `User : ` *'..user..'* is *Already* ` Globaly Banned..!`', 'md')
else
sendText(msg.chat_id, msg.id,'• _ User : _ `'..user..'` *Added* to `Globaly Banned` ..', 'md')
redis:sadd('GlobalyBanned:',user)
end
end
if cerner and cerner:match('^banall @(.*)') then
local username = cerner:match('^banall @(.*)')
function BanallByUsername(CerNer,Company)
if Company.id then
print(''..Company.id..'')
if redis:sismember('GlobalyBanned:', Company.id) then
text  ='• `User : ` *'..Company.id..'* is* Already* `  Globaly Banned..!`'
else
text= '• _ User : _ `'..Company.id..'` *Added* to `Globaly Banned`..'
redis:sadd('GlobalyBanned:',Company.id)
end
else 
text = '• *User NotFound*'
end
sendText(msg.chat_id, msg.id, text, 'md')
end
resolve_username(username,BanallByUsername)
end
if cerner == 'سوپر بن' then
function GbanByReply(CerNer,Company)
if redis:sismember('GlobalyBanned:',Company.sender_user_id or 00000000) then
sendText(msg.chat_id, msg.id,  '• `کاربر : ` *'..(Company.sender_user_id or 00000000)..'* از قبل از تمامی گروه های ربات محروم بود!`', 'md')
else
sendText(msg.chat_id, msg.id,'• _ کاربر : _ `'..(Company.sender_user_id or 00000000)..'` از تمامی گروه های ربات محروم شد', 'md')
redis:sadd('GlobalyBanned:',Company.sender_user_id or 00000000)
end
end
if tonumber(msg.reply_to_message_id) == 0 then
else
getMessage(msg.chat_id, tonumber(msg.reply_to_message_id),GbanByReply)
end
end
if cerner and cerner:match('^سوپر بن (%d+)') then
local user = cerner:match('^سوپر بن (%d+)')
if redis:sismember('GlobalyBanned:',user) then
sendText(msg.chat_id, msg.id,  '• `کاربر : ` *'..user..'* ز قبل از تمامی گروه های ربات محروم بود!`', 'md')
else
sendText(msg.chat_id, msg.id,'• _ کاربر : _ `'..user..'` از تمامی گروه های ربات محروم شد', 'md')
redis:sadd('GlobalyBanned:',user)
end
end
if cerner and cerner:match('^سوپر بن @(.*)') then
local username = cerner:match('^سوپر بن @(.*)')
function BanallByUsername(CerNer,Company)
if Company.id then
print(''..Company.id..'')
if redis:sismember('GlobalyBanned:', Company.id) then
text  ='• `کاربر : ` *'..Company.id..'* از قبل از تمامی گروه های ربات محروم بود!`'
else
text= '• _ کاربر : _ `'..Company.id..'` از تمامی گروه های ربات محروم شد'
redis:sadd('GlobalyBanned:',Company.id)
end
else 
text = '• *کاربر یافت نشد*'
end
sendText(msg.chat_id, msg.id, text, 'md')
end
resolve_username(username,BanallByUsername)
end
if cerner == 'gbans' then
local list = redis:smembers('GlobalyBanned:')
local t = 'Globaly Ban:\n'
for k,v in pairs(list) do
t = t..k.." - *"..v.."*\n" 
end
t = t.."\n\n• To see the user's from command under use!\nwhois ID\nExample ! \nwhois 363936960"
if #list == 0 then
t = 'The list is empty'
end
sendText(msg.chat_id, msg.id,t, 'md')
end
if cerner == 'لیست سوپر بن' then
local list = redis:smembers('GlobalyBanned:')
local t = 'Globaly Ban:\n'
for k,v in pairs(list) do
t = t..k.." - *"..v.."*\n" 
end
t = t.."\n\n• برای دیدن کاربر از دستور زیر استفاده کنید!\nچه کسی ایدی\nمثال ! \nچه کسی 363936960"
if #list == 0 then
t = 'لیست مورد نظر خالی میباشد'
end
sendText(msg.chat_id, msg.id,t, 'md')
end
if cerner == 'clean gbans' then
redis:del('GlobalyBanned:'..msg.chat_id)
sendText(msg.chat_id, msg.id,'• *Gobaly Banned* Has Been Cleared..', 'md')
end
if cerner == 'پاکسازی لیست سوپر بن' then
redis:del('GlobalyBanned:'..msg.chat_id)
sendText(msg.chat_id, msg.id,'• لیست کاربران محروم خالی شد', 'md')
end
---------------------Unbanall--------------------------------------
if cerner and cerner:match('^unbanall (%d+)') then
local user = cerner:match('unbanall (%d+)')
if tonumber(user) == tonumber(TD_ID) then
sendText(msg.chat_id, msg.id,  'اوه شت :( \nمن نمیتوانم پیام خودم را چک کنم', 'md')
return false
end
if redis:sismember('GlobalyBanned:',user) then
sendText(msg.chat_id, msg.id,'• _ کاربر : _ `'..user..'` *Removed* from `` Globaly Banned..', 'md')
redis:srem('GlobalyBanned:',user)
else
sendText(msg.chat_id, msg.id,  '• `User : ` *'..user..'* is *Not* ` Globaly Banned..!`', 'md')
end
end
if cerner and cerner:match('^unbanall @(.*)') then
local username = cerner:match('^unbanall @(.*)')
function UnbanallByUsername(CerNer,Company)
if tonumber(Company.id) == tonumber(TD_ID) then
sendText(msg.chat_id, msg.id,  'اوه شت :( \nمن نمیتوانم پیام خودم را چک کنم', 'md')
return false
end
if Company.id then
print(''..Company.id..'')
if redis:sismember('GlobalyBanned:', Company.id) then
text = '• _ User : _ `'..Company.id..'` *Removed* from `OwnerLis` Globaly Banned ..!'
redis:srem('GlobalyBanned:',Company.id)
else
text = '• `User : ` *'..user..'* is *Not* ` Globaly Banned..!`'
end
else 
text = '• *User NotFound*'
end
sendText(msg.chat_id, msg.id, text, 'md')
end
resolve_username(username,UnbanallByUsername)
end
if cerner == 'حذف سوپر بن' then
function UnGbanByReply(CerNer,Company)
if tonumber(Company.sender_user_id) == tonumber(TD_ID) then
sendText(msg.chat_id, msg.id,  'اوه شت :( \nمن نمیتوانم پیام خودم را چک کنم', 'md')
return false
end
if redis:sismember('GlobalyBanned:',Company.sender_user_id or 00000000) then
sendText(msg.chat_id, msg.id,'• _ کاربر : _ `'..(Company.sender_user_id or 00000000)..'` از محرومیت های گروه های ربات خارج شد', 'md')
redis:srem('GlobalyBanned:',Company.sender_user_id or 00000000)
else
sendText(msg.chat_id, msg.id,  '• `کاربر : ` *'..(Company.sender_user_id or 00000000)..'* از گروه های ربات محروم نبود!`', 'md')
end
end
if tonumber(msg.reply_to_message_id) == 0 then
else
getMessage(msg.chat_id, tonumber(msg.reply_to_message_id),UnGbanByReply)
end
end
if cerner and cerner:match('^حذف سوپر بن (%d+)') then
local user = cerner:match('حذف سوپر بن (%d+)')
if tonumber(user) == tonumber(TD_ID) then
sendText(msg.chat_id, msg.id,  'اوه شت :( \nمن نمیتوانم پیام خودم را چک کنم', 'md')
return false
end
if redis:sismember('GlobalyBanned:',user) then
sendText(msg.chat_id, msg.id,'• _ کاربر : _ `'..user..'` از محرومیت های گروه های ربات خارج شد', 'md')
redis:srem('GlobalyBanned:',user)
else
sendText(msg.chat_id, msg.id,  '• `کاربر : ` *'..user..'* از گروه های ربات محروم نبود!`', 'md')
end
end
if cerner and cerner:match('^حذف سوپر بن @(.*)') then
local username = cerner:match('^حذف سوپر بن @(.*)')
function UnbanallByUsername(CerNer,Company)
if tonumber(Company.id) == tonumber(TD_ID) then
sendText(msg.chat_id, msg.id,  'اوه شت :( \nمن نمیتوانم پیام خودم را چک کنم', 'md')
return false
end
if Company.id then
print(''..Company.id..'')
if redis:sismember('GlobalyBanned:', Company.id) then
text = '• _ کاربر : _ `'..Company.id..'` از محرومیت های گروه های ربات خارج شد'
redis:srem('GlobalyBanned:',Company.id)
else
text = '• `کاربر : ` *'..user..'* از گروه های ربات محروم نبود!`'
end
else 
text = '• *کاربر یافت نشد*'
end
sendText(msg.chat_id, msg.id, text, 'md')
end
resolve_username(username,UnbanallByUsername)
end
if cerner == 'unbanall' then
function UnGbanByReply(CerNer,Company)
if tonumber(Company.sender_user_id) == tonumber(TD_ID) then
sendText(msg.chat_id, msg.id,  'اوه شت :( \nمن نمیتوانم پیام خودم را چک کنم', 'md')
return false
end
if redis:sismember('GlobalyBanned:',Company.sender_user_id or 00000000) then
sendText(msg.chat_id, msg.id,'• _ کاربر : _ `'..(Company.sender_user_id or 00000000)..'` از محرومیت های گروه های ربات خارج شد', 'md')
redis:srem('GlobalyBanned:',Company.sender_user_id or 00000000)
else
sendText(msg.chat_id, msg.id,  '• `کاربر : ` *'..(Company.sender_user_id or 00000000)..'* از گروه های ربات محروم نبود!`', 'md')
end
end
if tonumber(msg.reply_to_message_id) == 0 then
else
getMessage(msg.chat_id, tonumber(msg.reply_to_message_id),UnGbanByReply)
end
end
if cerner == 'clean members' then 
    function CleanMembers(CerNer, Company) 
    for k, v in pairs(Company.members) do 
 if tonumber(v.user_id) == tonumber(TD_ID)  then
    return true
    end
KickUser(msg.chat_id,v.user_id)
end
end
print('CerNer')
getChannelMembers(msg.chat_id,"Recent",0, 2000000,CleanMembers)
sendText(msg.chat_id, msg.id,'• Done\nAll Memers  Has Been Kicked', 'md') 
end
if cerner == 'پاکسازی ممبر ها' then 
    function CleanMembers(CerNer, Company) 
    for k, v in pairs(Company.members) do 
 if tonumber(v.user_id) == tonumber(TD_ID)  then
    return true
    end
KickUser(msg.chat_id,v.user_id)
end
end
print('CerNer')
getChannelMembers(msg.chat_id,"Recent",0, 2000000,CleanMembers)
sendText(msg.chat_id, msg.id,'• انجام شد\nهمه ممبر ها اخراج شدند', 'md') 
end 
-------------------------------
end
if is_Owner(msg) then
if cerner == 'config' or cerner == 'پیکربندی' then
if not limit or limit > 200 then
    limit = 200
  end  
local function GetMod(extra,result,success)
local c = result.members
for i=0 , #c do
redis:sadd('ModList:'..msg.chat_id,c[i].user_id)
end
sendText(msg.chat_id,msg.id,"*تمام مدیران گروه به رسمیت شناخته شده اند*!", "md")
end
getChannelMembers(msg.chat_id,'Administrators',0,limit,GetMod)
end
if cerner == 'modlist' then
local list = redis:smembers('ModList:'..msg.chat_id)
local t = '• ModList\n'
for k,v in pairs(list) do
t = t..k.." - `"..v.."`\n" 
end
t = t.."\n\n• To see the user's from command under use!\nwhois ID\nExample ! \nwhois 363936960"
if #list == 0 then
t = 'The list is empty'
end
sendText(msg.chat_id, msg.id,t, 'md')
end
if cerner == 'لیست مدیران' then
local list = redis:smembers('ModList:'..msg.chat_id)
local t = '• لیست مدیران گروه\n'
for k,v in pairs(list) do
t = t..k.." - *"..v.."*\n" 
end
t = t.."\n\n• برای دیدن کاربر از دستور زیر استفاده کنید!\nچه کسی ایدی\nمثال ! \nچه کسی 363936960"
if #list == 0 then
t = 'لیست مورد نظر خالی میباشد'
end
sendText(msg.chat_id, msg.id,t, 'md')
end
if cerner and cerner:match('^unmuteuser (%d+)$') then
local mutes =  cerner:match('^unmuteuser (%d+)$')
if tonumber(mutes) == tonumber(TD_ID) then
sendText(msg.chat_id, msg.id,  'اوه شت :( \nمن نمیتوانم پیام خودم را چک کنم', 'md')
return false
end
redis:srem('MuteList:'..msg.chat_id,mutes)
mute(msg.chat_id, mutes,'Restricted',   {0, 0, 0, 0, 0,1})
sendText(msg.chat_id, msg.id,"• _Done_ \n*User* `"..mutes.."` *Has Been Unmuted* *\nRestricted*",  'md' )
end
if cerner and cerner:match('^حذف سکوت (%d+)$') then
local mutes =  cerner:match('^حذف سکوت (%d+)$')
if tonumber(mutes) == tonumber(TD_ID) then
sendText(msg.chat_id, msg.id,  'اوه شت :( \nمن نمیتوانم پیام خودم را چک کنم', 'md')
return false
end
redis:srem('MuteList:'..msg.chat_id,mutes)
mute(msg.chat_id, mutes,'Restricted',   {0, 0, 0, 0, 0,1})
sendText(msg.chat_id, msg.id,"• _انجام شد_ \n*کاربر* `"..mutes.."` *توانایی چت کردن رو بدست آورد* *\nRestricted*",  'md' )
end
 if cerner == 'promote' then
 function PromoteByReply(CerNer,Company)
 redis:sadd('ModList:'..msg.chat_id,Company.sender_user_id or 00000000)
 local user = Company.sender_user_id
sendText(msg.chat_id, msg.id, '• User '..(user or 00000000)..' Has Been Promoted','md')
end
if tonumber(msg.reply_to_message_id_) == 0 then
else
getMessage(msg.chat_id, tonumber(msg.reply_to_message_id), PromoteByReply)  
end
end
if cerner == 'مدیر' then
 function PromoteByReply(CerNer,Company)
 redis:sadd('ModList:'..msg.chat_id,Company.sender_user_id or 00000000)
 local user = Company.sender_user_id
sendText(msg.chat_id, msg.id, '• کاربر '..(user or 00000000)..' به مقام مدیر گروه منتصب شد','md')
end
if tonumber(msg.reply_to_message_id_) == 0 then
else
getMessage(msg.chat_id, tonumber(msg.reply_to_message_id), PromoteByReply)  
end
end
if cerner == 'demote' then
function DemoteByReply(CerNer,Company)
redis:srem('ModList:'..msg.chat_id,Company.sender_user_id or 00000000)
sendText(msg.chat_id, msg.id, '• User `'..(Company.sender_user_id or 00000000)..'`* Has Been Demoted*', 'md')
end
if tonumber(msg.reply_to_message_id) == 0 then
else
getMessage(msg.chat_id, tonumber(msg.reply_to_message_id),DemoteByReply)  
end
end
if cerner == 'حذف مدیر' then
function DemoteByReply(CerNer,Company)
redis:srem('ModList:'..msg.chat_id,Company.sender_user_id or 00000000)
sendText(msg.chat_id, msg.id, '• کاربر `'..(Company.sender_user_id or 00000000)..'`* از مقام مدیر گروه برکنار شد*', 'md')
end
if tonumber(msg.reply_to_message_id) == 0 then
else
getMessage(msg.chat_id, tonumber(msg.reply_to_message_id),DemoteByReply)  
end
end
if cerner and cerner:match('^demote @(.*)') then
local username = cerner:match('^demote @(.*)')
function DemoteByUsername(CerNer,Company)
if Company.id then
print(''..Company.id..'')
redis:srem('ModList:'..msg.chat_id,Company.id)
text = '• User `'..Company.id..'` Has Been Demoted'
else 
text = '• *User NotFound*'
end
sendText(msg.chat_id, msg.id, text, 'md')
end
resolve_username(username,DemoteByUsername)
end
if cerner and cerner:match('^حذف مدیر @(.*)') then
local username = cerner:match('^حذف مدیر @(.*)')
function DemoteByUsername(CerNer,Company)
if Company.id then
print(''..Company.id..'')
redis:srem('ModList:'..msg.chat_id,Company.id)
text = '• کاربر `'..Company.id..'` از مقام مدیر گروه برکنار شد'
else 
text = '• *کاربر یافت نشد*'
end
sendText(msg.chat_id, msg.id, text, 'md')
end
resolve_username(username,DemoteByUsername)
end
--------------------
if cerner and cerner:match('^مدیر @(.*)') then
local username = cerner:match('^مدیر @(.*)')
function PromoteByUsername(CerNer,Company)
if Company.id then
print(''..Company.id..'')
redis:sadd('ModList:'..msg.chat_id,Company.id)
text = '• User `'..Company.id..'` به مقام مدیر گروه منتصب شد'
else 
text = '• *کاربر یافت نشد*'
end
sendText(msg.chat_id, msg.id, text, 'md')
end
resolve_username(username,PromoteByUsername)
end
----------------------
if cerner1 and cerner1:match('^[Ss]etdescription (.*)') then
local description = cerner1:match('^[Ss]etdescription (.*)')
changeDes(msg.chat_id,description)
local text = [[description Has Been Changed To ]]..description
sendText(msg.chat_id, msg.id, text, 'md')
end
if cerner1 and cerner1:match('^تنظیم درباره (.*)') then
local description = cerner1:match('^تنظیم درباره (.*)')
changeDes(msg.chat_id,description)
local text = [[درباره گروه تغییر کرده به ]]..description
sendText(msg.chat_id, msg.id, text, 'md')
end
if cerner1 and cerner1:match('^[Ss]etname (.*)') then
local Title = cerner1:match('^[Ss]etname (.*)')
local function GetName(CerNer, Company)
local Hash = 'StatsGpByName'..msg.chat_id
local ChatTitle = Company.title
redis:set(Hash,ChatTitle)
changeChatTitle(msg.chat_id,Title)
local text = [[Group Name Has Been Changed To ]]..Title
sendText(msg.chat_id, msg.id, text, 'md')
end
GetChat(msg.chat_id,GetName)
end
if cerner1 and cerner1:match('^تنظیم نام (.*)') then
local Title = cerner1:match('^تنظیم نام (.*)')
local function GetName(CerNer, Company)
local Hash = 'StatsGpByName'..msg.chat_id
local ChatTitle = Company.title
redis:set(Hash,ChatTitle)
changeChatTitle(msg.chat_id,Title)
local text = [[نام گروه تغییر کرد به ]]..Title
sendText(msg.chat_id, msg.id, text, 'md')
end
GetChat(msg.chat_id,GetName)
end
if cerner and cerner:match('^promote (%d+)') then
local user = cerner:match('promote (%d+)')
redis:sadd('ModList:'..msg.chat_id,user)
sendText(msg.chat_id, msg.id, '• User `'..user..'`* Has Been Promoted*', 'md')
end
if cerner and cerner:match('^مدیر (%d+)') then
local user = cerner:match('مدیر (%d+)')
redis:sadd('ModList:'..msg.chat_id,user)
sendText(msg.chat_id, msg.id, '• کاربر `'..user..'`* به مقام مدیر گروه منتصب شد*', 'md')
end
if cerner == 'pin' then
sendText(msg.chat_id,msg.reply_to_message_id, '• Msg Has Been Pinned' ,'md')
Pin(msg.chat_id,msg.reply_to_message_id, 1)
end
if cerner == 'سنجاق' then
sendText(msg.chat_id,msg.reply_to_message_id, '• پیام سنجاق شد' ,'md')
Pin(msg.chat_id,msg.reply_to_message_id, 1)
end
if cerner == 'unpin' then
sendText(msg.chat_id,msg.id, '• Msg Has Been UnPinned' ,'md')
Unpin(msg.chat_id)
end
if cerner == 'حذف سنجاق' then
sendText(msg.chat_id,msg.id, '• پیام سنجاق شده پاک شد' ,'md')
Unpin(msg.chat_id)
end
if cerner and cerner:match('^demote (%d+)') then
local user = cerner:match('demote (%d+)')
redis:srem('ModList:'..msg.chat_id,user)
sendText(msg.chat_id, msg.id, '• User `'..user..'`* Has Been Demoted*', 'md')
end
if cerner and cerner:match('^حذف مدیر (%d+)') then
local user = cerner:match('حذف مدیر (%d+)')
redis:srem('ModList:'..msg.chat_id,user)
sendText(msg.chat_id, msg.id, '• کاربر `'..user..'`* از مقام مدیر گروه برکنار شد*', 'md')
end
if cerner == 'lock all' then
redis:set('MuteAll:'..msg.chat_id,true)
sendText(msg.chat_id, msg.id,'• Lock ALL Has Been Enabled' ,'md')
end
if cerner == 'قفل همه' then
redis:set('MuteAll:'..msg.chat_id,true)
sendText(msg.chat_id, msg.id,'• قفل گروه فعال شد' ,'md')
end
if cerner == 'unlock all' then
redis:del('MuteAll:'..msg.chat_id)
local mutes =  redis:smembers('Mutes:'..msg.chat_id)
for k,v in pairs(mutes) do
redis:srem('MuteList:'..msg.chat_id,v)
mute(msg.chat_id,v,'Restricted',   {1, 1, 1, 1, 1,1})
end
sendText(msg.chat_id, msg.id,'Lock All Has Been Disabled' ,'md')
end
if cerner == 'باز همه' then
redis:del('MuteAll:'..msg.chat_id)
local mutes =  redis:smembers('Mutes:'..msg.chat_id)
for k,v in pairs(mutes) do
redis:srem('MuteList:'..msg.chat_id,v)
mute(msg.chat_id,v,'Restricted',   {1, 1, 1, 1, 1,1})
end
sendText(msg.chat_id, msg.id,'قفل گروه غیرفعال شد' ,'md')
end
   if cerner == 'clean modlist'  then
redis:del('ModList:'..msg.chat_id)
sendText(msg.chat_id, msg.id,  '• ModList List Has Been Cleaned', 'md')
end
if cerner == 'پاکسازی لیست مدیران'  then
redis:del('ModList:'..msg.chat_id)
sendText(msg.chat_id, msg.id,  '• لیست مدیران خالی شد', 'md')
end
if cerner == 'clean ownerlist'  then
redis:del('OwnerList:'..msg.chat_id)
sendText(msg.chat_id, msg.id,  '• Ownerlist List Has Been Cleaned', 'md')
end
if cerner == 'پاکسازی لیست مالکان'  then
redis:del('OwnerList:'..msg.chat_id)
sendText(msg.chat_id, msg.id,  '• لیست مالکان خالی شد', 'md')
end
----
end
----
if is_Mod(msg) then
-----------Delete All-------------
if cerner == 'delall' then
function DelallByReply(CerNer,Company)
if tonumber(Company.sender_user_id or 00000000) == tonumber(TD_ID) then
sendText(msg.chat_id, msg.id, "اوه شت :( \nمن نمیتوانم پیام های خودم را پاک کنم", 'md')
return false
end
if private(msg.chat_id,Company.sender_user_id or 000000000000000000000000000000000000000000000000) then
print '                     Private                          '
sendText(msg.chat_id, msg.id, "اوه شت :(\nمن نمیتوانم پیام های یک فرد دارای  مقام را پاک کنم ", 'md')
else
sendText(msg.chat_id, msg.id, '• ALL Message  `'..(Company.sender_user_id or 00000000)..'`* Has Been Deleted*', 'md')
deleteMessagesFromUser(msg.chat_id,Company.sender_user_id or 00000000) 
end
end
if tonumber(msg.reply_to_message_id) == 0 then
else
getMessage(msg.chat_id, tonumber(msg.reply_to_message_id),DelallByReply)  
end
end
if cerner and cerner:match('^delall @(.*)') then
local username = cerner:match('^delall @(.*)')
function DelallByUsername(CerNer,Company)
if tonumber(Company.id) == tonumber(TD_ID) then
  sendText(msg.chat_id, msg.id, "اوه شت :( \nمن نمیتوانم پیام های خودم را پاک کنم", "md")
return false
    end
  if private(msg.chat_id,Company.id or 000000000000000000000000000000000000000000000000) then
print '                     Private                          '
sendText(msg.chat_id, msg.id, "اوه شت :(\nمن نمیتوانم پیام های یک فرد دارای  مقام را پاک کنم ", "md")
else
if Company.id then
text= '• ALL Message  `'..Company.id..'`* Has Been Deleted*'
deleteMessagesFromUser(msg.chat_id,Company.id) 
else 
text = '• *User NotFound*'
end
sendText(msg.chat_id, msg.id, text, 'md')
end
end
resolve_username(username,DelallByUsername)
end
if cerner and cerner:match('^delall (%d+)') then
local user_id = cerner:match('^delall (%d+)')
if tonumber(user_id) == tonumber(TD_ID) then
  sendText(msg.chat_id, msg.id, "اوه شت :( \nمن نمیتوانم پیام های خودم را پاک کنم", "md")
return false
    end
  if private(msg.chat_id,user_id or 000000000000000000000000000000000000000000000000) then
print '                      Private                          '
sendText(msg.chat_id, msg.id, "اوه شت :(\nمن نمیتوانم پیام های یک فرد دارای  مقام را پاک کنم ", "md")   
else
text= '• ALL Message  `'..user_id..'`* Has Been Deleted*'
deleteMessagesFromUser(msg.chat_id,user_id) 
sendText(msg.chat_id, msg.id, text, 'md')
end
end
---------------------------------
if cerner == 'پاکسازی همه' then
function DelallByReply(CerNer,Company)
if tonumber(Company.sender_user_id or 00000000) == tonumber(TD_ID) then
sendText(msg.chat_id, msg.id, "اوه شت :( \nمن نمیتوانم پیام های خودم را پاک کنم", 'md')
return false
end
if private(msg.chat_id,Company.sender_user_id or 000000000000000000000000000000000000000000000000) then
print '                     Private                          '
sendText(msg.chat_id, msg.id, "اوه شت :(\nمن نمیتوانم پیام های یک فرد دارای  مقام را پاک کنم ", 'md')
else
sendText(msg.chat_id, msg.id, '• تمام پیام های کاربر  `'..(Company.sender_user_id or 00000000)..'`* پاک شدند*', 'md')
deleteMessagesFromUser(msg.chat_id,Company.sender_user_id or 00000000) 
end
end
if tonumber(msg.reply_to_message_id) == 0 then
else
getMessage(msg.chat_id, tonumber(msg.reply_to_message_id),DelallByReply)  
end
end
if cerner and cerner:match('^پاکسازی همه @(.*)') then
local username = cerner:match('^پاکسازی همه @(.*)')
function DelallByUsername(CerNer,Company)
if tonumber(Company.id) == tonumber(TD_ID) then
  sendText(msg.chat_id, msg.id, "اوه شت :( \nمن نمیتوانم پیام های خودم را پاک کنم", "md")
return false
    end
  if private(msg.chat_id,Company.id or 000000000000000000000000000000000000000000000000) then
print '                     Private                          '
sendText(msg.chat_id, msg.id, "اوه شت :(\nمن نمیتوانم پیام های یک فرد دارای  مقام را پاک کنم ", "md")
else
if Company.id then
text= '• تمام پیام های کاربر  `'..Company.id..'`* پاک شدند*'
deleteMessagesFromUser(msg.chat_id,Company.id) 
else 
text = '• *User NotFound*'
end
sendText(msg.chat_id, msg.id, text, 'md')
end
end
resolve_username(username,DelallByUsername)
end
if cerner and cerner:match('^پاکسازی همه (%d+)') then
local user_id = cerner:match('^پاکسازی همه (%d+)')
if tonumber(user_id) == tonumber(TD_ID) then
  sendText(msg.chat_id, msg.id, "اوه شت :( \nمن نمیتوانم پیام های خودم را پاک کنم", "md")
return false
    end
  if private(msg.chat_id,user_id or 000000000000000000000000000000000000000000000000) then
print '                      Private                          '
sendText(msg.chat_id, msg.id, "اوه شت :(\nمن نمیتوانم پیام های یک فرد دارای  مقام را پاک کنم ", "md")   
else
text= '• تمام پیام های کاربر   `'..user_id..'`* پاک شدند*'
deleteMessagesFromUser(msg.chat_id,user_id) 
sendText(msg.chat_id, msg.id, text, 'md')
end
end
---------------------------------
if cerner == 'viplist' then
local list = redis:smembers('Vip:'..msg.chat_id)
local t = '• Vip Users\n'
for k,v in pairs(list) do
t = t..k.." - *"..v.."*\n" 
end
t = t.."\n\n• To see the user's from command under use!\nwhois ID\nExample ! \nwhois 363936960"
if #list == 0 then
t = 'The list is empty'
end
sendText(msg.chat_id, msg.id,t, 'md')
end
if cerner == 'لیست کاربران ویژه' then
local list = redis:smembers('Vip:'..msg.chat_id)
local t = '• کاربران ویژه\n'
for k,v in pairs(list) do
t = t..k.." - *"..v.."*\n" 
end
t = t.."\n\n• برای دیدن کاربر از دستور زیر استفاده کنید!\nچه کسی ایدی\nمثال ! \nچه کسی 363936960"
if #list == 0 then
t = 'لیست مورد نظر خالی میباشد'
end
sendText(msg.chat_id, msg.id,t, 'md')
end
if cerner == 'banlist' then
local list = redis:smembers('BanUser:'..msg.chat_id)
local t = '• Ban Users\n'
for k,v in pairs(list) do
t = t..k.." - *"..v.."*\n" 
end
t = t.."\n\n• To see the user's from command under use!\nwhois ID\nExample ! \nwhois 363936960"
if #list == 0 then
t = 'The list is empty'
end
sendText(msg.chat_id, msg.id,t, 'md')
end
if cerner == 'لیست بن' then
local list = redis:smembers('BanUser:'..msg.chat_id)
local t = '• لیست بن\n'
for k,v in pairs(list) do
t = t..k.." - *"..v.."*\n" 
end
t = t.."\n\n• برای دیدن کاربر از دستور زیر استفاده کنید!\nچه کسی ایدی\nمثال ! \nچه کسی 363936960"
if #list == 0 then
t = 'لیست مورد نظر خالی میباشد'
end
sendText(msg.chat_id, msg.id,t, 'md')
end
  if cerner == 'clean banlist'  then
local function Clean(CerNer,Company)
for k,v in pairs(Company.members) do
redis:del('BanUser:'..msg.chat_id)
RemoveFromBanList(msg.chat_id, v.user_id) 
end
end
sendText(msg.chat_id, msg.id,  '• All User Banned Has Been Cleaned From BanList', 'md')
getChannelMembers(msg.chat_id, "Banned", 0, 100000000000,Clean)
end
if cerner == 'پاکسازی لیست بن'  then
local function Clean(CerNer,Company)
for k,v in pairs(Company.members) do
redis:del('BanUser:'..msg.chat_id)
RemoveFromBanList(msg.chat_id, v.user_id) 
end
end
sendText(msg.chat_id, msg.id,  '• لیست کاربران محروم گروه خالی شد', 'md')
getChannelMembers(msg.chat_id, "Banned", 0, 100000000000,Clean)
end
 if cerner == 'clean mutelist'  then
local mute = redis:smembers('MuteList:'..msg.chat_id)
for k,v in pairs(mute) do
redis:del('MuteList:'..msg.chat_id)
mute(msg.chat_id, v,'Restricted',   {1, 1, 0, 0, 0,0})
end
sendText(msg.chat_id, msg.id,  '• All User Muted Has Been Cleaned From MuteList', 'md')
end
if cerner == 'پاکسازی لیست سکوت'  then
local mute = redis:smembers('MuteList:'..msg.chat_id)
for k,v in pairs(mute) do
redis:del('MuteList:'..msg.chat_id)
mute(msg.chat_id, v,'Restricted',   {1, 1, 0, 0, 0,0})
end
sendText(msg.chat_id, msg.id,  '•لیست کابران ساکت شده خالی شد', 'md')
end
if cerner == 'clean bots'  then
local function CleanBot(CerNer,Company)
for k,v in pairs(Company.members) do
if tonumber(v.user_id) == tonumber(TD_ID) then
return false
end
 if private(msg.chat_id,v.user_id or 000000000000000000000000000000000000000000000000) then
print '                      Private                          '
else
end
KickUser(msg.chat_id, v.user_id) 
end
end
sendText(msg.chat_id, msg.id,  '• All Bots Banned Has Been Kicked', 'md')
getChannelMembers(msg.chat_id, "Bots", 0, 100000000000,CleanBot)
end
if cerner == 'پاکسازی ربات ها'  then
local function CleanBot(CerNer,Company)
for k,v in pairs(Company.members) do
if tonumber(v.user_id) == tonumber(TD_ID) then
return false
end
 if private(msg.chat_id,v.user_id or 000000000000000000000000000000000000000000000000) then
print '                      Private                          '
else
end
KickUser(msg.chat_id, v.user_id) 
end
end
sendText(msg.chat_id, msg.id,  '• تمامی ربات ها از گروه اخراج شدند', 'md')
getChannelMembers(msg.chat_id, "Bots", 0, 100000000000,CleanBot)
end
if cerner == 'setvip' then
function SetVipByReply(CerNer,Company)
if redis:sismember('Vip:'..msg.chat_id, Company.sender_user_id or 00000000) then
sendText(msg.chat_id, msg.id,  '• `User : ` *'..(Company.sender_user_id or 00000000)..'* is *Already* `a VIP member..!`', 'md')
else
sendText(msg.chat_id, msg.id,'• _ User : _ `'..(Company.sender_user_id or 00000000)..'` *Promoted* to `VIP` member..', 'md')
redis:sadd('Vip:'..msg.chat_id, Company.sender_user_id or 00000000)
end
end
getMessage(msg.chat_id, tonumber(msg.reply_to_message_id),SetVipByReply)
end
if cerner and cerner:match('^setvip @(.*)') then
local username = cerner:match('^setvip @(.*)')
function SetVipByUsername(CerNer,Company)
if Company.id then
print('SetVip\nBy : '..msg.sender_user_id..'\nUser : '..Company.id..'\nUserName : '..username)
if redis:sismember('Vip:'..msg.chat_id,Company.id) then
text=  '• `User : ` *'..Company.id..'* is *Already* `a VIP member..!`'
else
text ='• _ User : _ `'..Company.id..'` *Promoted* to `VIP` member..'
redis:sadd('Vip:'..msg.chat_id, Company.id)
end
else 
text = '• *User NotFound*'
end
sendText(msg.chat_id, msg.id, text, 'md')
end
resolve_username(username,SetVipByUsername)
end 
  if cerner == 'clean viplist'  then
redis:del('Vip:'..msg.chat_id)
sendText(msg.chat_id, msg.id,  '• Vip List Has Been Cleaned', 'md')
end
if cerner == 'remvip' then
function RemVipByReply(CerNer,Company)
if redis:sismember('Vip:'..msg.chat_id, Company.sender_user_id or 00000000) then
sendText(msg.chat_id, msg.id,'• _User : _ `'..(Company.sender_user_id or 00000000)..'` *Demoted From VIP Member..*', 'md')
redis:srem('Vip:'..msg.chat_id, Company.sender_user_id or 00000000)
else
sendText(msg.chat_id, msg.id,  '• `User : ` *'..(Company.sender_user_id or 00000000)..'* `Not VIP Member..!`', 'md')
end
end
getMessage(msg.chat_id, tonumber(msg.reply_to_message_id),RemVipByReply)
end
-------------------------------------------------------------
if cerner == 'عضو ویژه' then
function SetVipByReply(CerNer,Company)
if redis:sismember('Vip:'..msg.chat_id, Company.sender_user_id or 00000000) then
sendText(msg.chat_id, msg.id,  '• `کاربر : ` *'..(Company.sender_user_id or 00000000)..'* از قبل عضو ویژه بود..!`', 'md')
else
sendText(msg.chat_id, msg.id,'• _ کاربر : _ `'..(Company.sender_user_id or 00000000)..'` عضو ویژه شد..', 'md')
redis:sadd('Vip:'..msg.chat_id, Company.sender_user_id or 00000000)
end
end
getMessage(msg.chat_id, tonumber(msg.reply_to_message_id),SetVipByReply)
end
if cerner and cerner:match('^عضو ویژه @(.*)') then
local username = cerner:match('^عضو ویژه @(.*)')
function SetVipByUsername(CerNer,Company)
if Company.id then
print('SetVip\nBy : '..msg.sender_user_id..'\nUser : '..Company.id..'\nUserName : '..username)
if redis:sismember('Vip:'..msg.chat_id,Company.id) then
text=  '• `کاربر : ` *'..Company.id..'* از قبل عضو ویژه بود..!`'
else
text ='• _ کاربر : _ `'..Company.id..'` عضو ویژه شد..'
redis:sadd('Vip:'..msg.chat_id, Company.id)
end
else 
text = '• *کاربر یافت نشد*'
end
sendText(msg.chat_id, msg.id, text, 'md')
end
resolve_username(username,SetVipByUsername)
end 
  if cerner == 'پاکسازی لیست کاربران ویژه'  then
redis:del('Vip:'..msg.chat_id)
sendText(msg.chat_id, msg.id,  '• لیست کاربران ویژه خالی شد', 'md')
end
if cerner == 'حذف عضو ویژه' then
function RemVipByReply(CerNer,Company)
if redis:sismember('Vip:'..msg.chat_id, Company.sender_user_id or 00000000) then
sendText(msg.chat_id, msg.id,'• کاربر : _ `'..(Company.sender_user_id or 00000000)..'` از مقام عضو ویژه برکنار شد..*', 'md')
redis:srem('Vip:'..msg.chat_id, Company.sender_user_id or 00000000)
else
sendText(msg.chat_id, msg.id,  '• `کاربر : ` *'..(Company.sender_user_id or 00000000)..'* عضو ویژه نبود..!`', 'md')
end
end
getMessage(msg.chat_id, tonumber(msg.reply_to_message_id),RemVipByReply)
end
-------------------------------------------------------------

if cerner and cerner:match('^muteuser (%d+)$') then
local mutess = cerner:match('^muteuser (%d+)$') 
if tonumber(mutess) == tonumber(TD_ID) then
sendText(msg.chat_id, msg.id,  'اوه شت :( \nمن نمیتوانم خودم را محدود کنم ', 'md')
return false
end
if private(msg.chat_id,mutess) then
sendText(msg.chat_id, msg.id, "اوه شت :(\nمن نمیتوانم یک فرد داری مقام را محدود کنم ", 'md')
else
mute(msg.chat_id, mutess,'Restricted',   {1, 0, 0, 0, 0,0})
redis:sadd('MuteList:'..msg.chat_id,mutess)
sendText(msg.chat_id, msg.id,"• *Done User* `"..mutess.."` *Has Been  Muteed :) \nRestricted*",  'md' )
end
end
if cerner and cerner:match('^سکوت (%d+)$') then
local mutess = cerner:match('^سکوت (%d+)$') 
if tonumber(mutess) == tonumber(TD_ID) then
sendText(msg.chat_id, msg.id,  'اوه شت :( \nمن نمیتوانم خودم را محدود کنم ', 'md')
return false
end
if private(msg.chat_id,mutess) then
sendText(msg.chat_id, msg.id, "اوه شت :(\nمن نمیتوانم یک فرد داری مقام را محدود کنم ", 'md')
else
mute(msg.chat_id, mutess,'Restricted',   {1, 0, 0, 0, 0,0})
redis:sadd('MuteList:'..msg.chat_id,mutess)
sendText(msg.chat_id, msg.id,"• *کاربر* `"..mutess.."` *توانایی چت کردن رو از دست داد :) \nRestricted*",  'md' )
end
end
if cerner1 and cerner1:match('^([Ss]etflood) (.*)$') then
local status = {string.match(cerner, "^([Ss]etflood) (.*)$")}
if status[2] == 'kickuser' then
redis:set("Flood:Status:"..msg.chat_id,'kickuser') 
sendText(msg.chat_id, msg.id, '*Flood mode is set to* _Kickuser_', 'md')
end
if status[2] == 'muteuser' then
redis:set("Flood:Status:"..msg.chat_id,'muteuser') 
sendText(msg.chat_id, msg.id, '*Flood mode is set to* _Muteuser_', 'md')
end
end
if cerner1 and cerner1:match('^وضعیت پیام رگباری اخراج$') then
redis:set("Flood:Status:"..msg.chat_id,'kickuser') 
sendText(msg.chat_id, msg.id, 'وضعیت پیام رگباری بر روی اخراج قرار گرفت', 'md')
end
if cerner1 and cerner1:match('^وضعیت پیام رگباری سکوت$') then
redis:set("Flood:Status:"..msg.chat_id,'muteuser') 
sendText(msg.chat_id, msg.id, 'وضعیت پیام رگباری بر روی سکوت قرار گرفته', 'md')
end
if cerner == 'muteuser' then
local function Restricted(CerNer,Company)
if tonumber(Company.sender_user_id or 00000000) == tonumber(TD_ID) then
sendText(msg.chat_id, msg.id,  'اوه شت :( \nمن نمیتوانم خودم را محدود کنم ', 'md')
return false
end
if private(msg.chat_id,Company.sender_user_id or 00000000) then
sendText(msg.chat_id, msg.id, "اوه شت :(\nمن نمیتوانم یک فرد داری مقام را محدود کنم ", 'md')
else
mute(msg.chat_id, Company.sender_user_id or 00000000,'Restricted',   {1, 0, 0, 0, 0,0})
redis:sadd('MuteList:'..msg.chat_id,Company.sender_user_id or 00000000)
SendMetion(msg.chat_id,Company.sender_user_id, msg.id, "• Done User "..Company.sender_user_id.." Has Been  Muteed", 12,string.len(Company.sender_user_id))
end
end
if tonumber(msg.reply_to_message_id) == 0 then
else
getMessage(msg.chat_id, tonumber(msg.reply_to_message_id),Restricted)  
end
end
if cerner == 'سکوت' then
local function Restricted(CerNer,Company)
if tonumber(Company.sender_user_id or 00000000) == tonumber(TD_ID) then
sendText(msg.chat_id, msg.id,  'اوه شت :( \nمن نمیتوانم خودم را محدود کنم ', 'md')
return false
end
if private(msg.chat_id,Company.sender_user_id or 00000000) then
sendText(msg.chat_id, msg.id, "اوه شت :(\nمن نمیتوانم یک فرد داری مقام را محدود کنم ", 'md')
else
mute(msg.chat_id, Company.sender_user_id or 00000000,'Restricted',   {1, 0, 0, 0, 0,0})
redis:sadd('MuteList:'..msg.chat_id,Company.sender_user_id or 00000000)
SendMetion(msg.chat_id,Company.sender_user_id, msg.id, "• کاربر "..Company.sender_user_id.." توانایی چت کردن رو از دست داد", 12,string.len(Company.sender_user_id))
end
end
if tonumber(msg.reply_to_message_id) == 0 then
else
getMessage(msg.chat_id, tonumber(msg.reply_to_message_id),Restricted)  
end
end
if cerner == 'unmuteuser' then
function Restricted(CerNer,Company)
if tonumber(Company.sender_user_id or 00000000) == tonumber(TD_ID) then
sendText(msg.chat_id, msg.id,  'اوه شت :( \nمن نمیتوانم پیام خودم را چک کنم', 'md')
return false
end
redis:srem('MuteList:'..msg.chat_id,Company.sender_user_id or 00000000)
mute(msg.chat_id,Company.sender_user_id or 00000000,'Restricted',   {1, 1, 1, 1, 1,1})
SendMetion(msg.chat_id,Company.sender_user_id, msg.id, "• Done User "..Company.sender_user_id.." Has Been  UnMuteed", 12,string.len(Company.sender_user_id))
end
if tonumber(msg.reply_to_message_id) == 0 then
else
getMessage(msg.chat_id, tonumber(msg.reply_to_message_id),Restricted)  
end
end
if cerner == 'حذف سکوت' then
function Restricted(CerNer,Company)
if tonumber(Company.sender_user_id or 00000000) == tonumber(TD_ID) then
sendText(msg.chat_id, msg.id,  'اوه شت :( \nمن نمیتوانم پیام خودم را چک کنم', 'md')
return false
end
redis:srem('MuteList:'..msg.chat_id,Company.sender_user_id or 00000000)
mute(msg.chat_id,Company.sender_user_id or 00000000,'Restricted',   {1, 1, 1, 1, 1,1})
SendMetion(msg.chat_id,Company.sender_user_id, msg.id, "• کاربر "..Company.sender_user_id.." توانایی چت کردن رو بدست آورد", 12,string.len(Company.sender_user_id))
end
if tonumber(msg.reply_to_message_id) == 0 then
else
getMessage(msg.chat_id, tonumber(msg.reply_to_message_id),Restricted)  
end
end
if cerner and cerner:match('^unmuteuser (%d+)$') then
local mutes =  cerner:match('^unmuteuser (%d+)$')
if tonumber(mutes) == tonumber(TD_ID) then
sendText(msg.chat_id, msg.id,  'اوه شت :( \nمن نمیتوانم پیام خودم را چک کنم', 'md')
return false
end
redis:srem('MuteList:'..msg.chat_id,mutes)
mute(msg.chat_id, mutes,'Restricted',   {1, 1, 1, 1, 1,1})
SendMetion(msg.chat_id,Company.sender_user_id, msg.id, "• Done User "..Company.sender_user_id.." Has Been  UnMuteed", 12,string.len(Company.sender_user_id))
end
if cerner and cerner:match('^حذف سکوت (%d+)$') then
local mutes =  cerner:match('^حذف سکوت (%d+)$')
if tonumber(mutes) == tonumber(TD_ID) then
sendText(msg.chat_id, msg.id,  'اوه شت :( \nمن نمیتوانم پیام خودم را چک کنم', 'md')
return false
end
redis:srem('MuteList:'..msg.chat_id,mutes)
mute(msg.chat_id, mutes,'Restricted',   {1, 1, 1, 1, 1,1})
SendMetion(msg.chat_id,Company.sender_user_id, msg.id, "• کاربر "..Company.sender_user_id.." توانایی چت کردن رو بدست آورد", 12,string.len(Company.sender_user_id))
end
if cerner == 'setlink'  and tonumber(msg.reply_to_message_id) > 0 then
function GeTLink(CerNer,Company)
local getlink = Company.content.text or Company.content.caption
for link in getlink:gmatch("(https://t.me/joinchat/%S+)") or getlink:gmatch("t.me", "telegram.me") do
redis:set('Link:'..msg.chat_id,link)
print(link)
end
sendText(msg.chat_id, msg.id,"Done ! ",  'md' )
end
getMessage(msg.chat_id, tonumber(msg.reply_to_message_id),GeTLink)
end
if cerner == 'remlink' then
redis:del('Link:'..msg.chat_id)
sendText(msg.chat_id, msg.id,"Link Removed ",  'md' )
end
if cerner == 'تنظیم لینک'  and tonumber(msg.reply_to_message_id) > 0 then
function GeTLink(CerNer,Company)
local getlink = Company.content.text or Company.content.caption
for link in getlink:gmatch("(https://t.me/joinchat/%S+)") or getlink:gmatch("t.me", "telegram.me") do
redis:set('Link:'..msg.chat_id,link)
print(link)
end
sendText(msg.chat_id, msg.id,"انجام شد ! ",  'md' )
end
getMessage(msg.chat_id, tonumber(msg.reply_to_message_id),GeTLink)
end
if cerner == 'حذف لینک' then
redis:del('Link:'..msg.chat_id)
sendText(msg.chat_id, msg.id,"لینک پاک شد",  'md' )
end
if cerner == 'ban' and tonumber(msg.reply_to_message_id) > 0 then
function BanByReply(CerNer,Company)
if tonumber(Company.sender_user_id or 00000000) == tonumber(TD_ID) then
sendText(msg.chat_id, msg.id,"اوه شت :( \nمن نمیتوانم خودم را محدود کنم",  'md' )
return false
end
  if private(msg.chat_id,Company.sender_user_id or 00000000) then
print '                     Private                          '
  sendText(msg.chat_id, msg.id, "اوه شت :(\nمن نمیتوانم یک کاربر دارای مقام را مسدود کنم", 'md')
    else
SendMetion(msg.chat_id,Company.sender_user_id, msg.id, "• User "..(Company.sender_user_id or 021).." Has Been Banned", 7,string.len(Company.sender_user_id))
redis:sadd('BanUser:'..msg.chat_id,Company.sender_user_id or 00000000)
KickUser(msg.chat_id,Company.sender_user_id)
end
end
getMessage(msg.chat_id, tonumber(msg.reply_to_message_id),BanByReply)
end
if cerner == 'بن' and tonumber(msg.reply_to_message_id) > 0 then
function BanByReply(CerNer,Company)
if tonumber(Company.sender_user_id or 00000000) == tonumber(TD_ID) then
sendText(msg.chat_id, msg.id,"اوه شت :( \nمن نمیتوانم خودم را محدود کنم",  'md' )
return false
end
  if private(msg.chat_id,Company.sender_user_id or 00000000) then
print '                     Private                          '
  sendText(msg.chat_id, msg.id, "اوه شت :(\nمن نمیتوانم یک کاربر دارای مقام را مسدود کنم", 'md')
    else
SendMetion(msg.chat_id,Company.sender_user_id, msg.id, "• کاربر "..(Company.sender_user_id or 021).." از گروه محروم شد", 7,string.len(Company.sender_user_id))
redis:sadd('BanUser:'..msg.chat_id,Company.sender_user_id or 00000000)
KickUser(msg.chat_id,Company.sender_user_id)
end
end
getMessage(msg.chat_id, tonumber(msg.reply_to_message_id),BanByReply)
end
  if cerner == 'clean filterlist'  then
redis:del('Filters:'..msg.chat_id)
sendText(msg.chat_id, msg.id,  '• Filter List Has Been Cleaned', 'md')
end
if cerner == 'پاکسازی لیست فیلتر'  then
redis:del('Filters:'..msg.chat_id)
sendText(msg.chat_id, msg.id,  '• لیست فیلتر خالی شد', 'md')
end
if cerner == 'filterlist' then
local list = redis:smembers('Filters:'..msg.chat_id)
local t = '• Filters \n'
for k,v in pairs(list) do
t = t..k.." - *"..v.."*\n" 
end
if #list == 0 then
t = '• The list is empty'
end
sendText(msg.chat_id, msg.id,t, 'md')
end
if cerner == 'لیست فیلتر' then
local list = redis:smembers('Filters:'..msg.chat_id)
local t = '• لیست فیلتر \n'
for k,v in pairs(list) do
t = t..k.." - *"..v.."*\n" 
end
if #list == 0 then
t = '• لیست مورد نظر خالی میباشد'
end
sendText(msg.chat_id, msg.id,t, 'md')
end
if cerner == 'mutelist' then
local list = redis:smembers('MuteList:'..msg.chat_id)
local t = '• Mute List \n'
for k,v in pairs(list) do
t = t..k.." - *"..v.."*\n" 
end
t = t.."\n\n• To see the user's from command under use!\nwhois ID\nExample ! \nwhois 363936960"
if #list == 0 then
t = 'The list is empty'
end
sendText(msg.chat_id, msg.id,t, 'md')
end
if cerner == 'لیست سکوت' then
local list = redis:smembers('MuteList:'..msg.chat_id)
local t = '• لیست سکوت \n'
for k,v in pairs(list) do
t = t..k.." - *"..v.."*\n" 
end
t = t.."\n\n• برای دیدن کاربر از دستور زیر استفاده کنید!\nچه کسی ایدی\nمثال ! \nچه کسی 363936960"
if #list == 0 then
t = 'لیست مورد نظر خالی میباشد'
end
sendText(msg.chat_id, msg.id,t, 'md')
end
if cerner == 'clean warnlist' then
redis:del(msg.chat_id..':warn')
sendText(msg.chat_id, msg.id,'Warn List Has Been Cleaned', 'md')
end
if cerner == 'پاکسازی لیست اخطار' then
redis:del(msg.chat_id..':warn')
sendText(msg.chat_id, msg.id,'لیست اخطار خالی شد', 'md')
end
if cerner == "warnlist" then
local comn = redis:hkeys(msg.chat_id..':warn')
local t = 'Warn Users List:\n'
for k,v in pairs (comn) do
local cont = redis:hget(msg.chat_id..':warn', v)
t = t..k..'- '..v..' Warn : '..(cont - 1)..'\n'
end
t = t.."\n\n• To see the user's from command under use!\nwhois ID\nExample ! \nwhois 363936960"
if #comn == 0 then
t = 'The list is empty'
end 
sendText(msg.chat_id, msg.id,t, 'md')
end
if cerner == "لیست اخطار" then
local comn = redis:hkeys(msg.chat_id..':warn')
local t = 'لیست اخطار:\n'
for k,v in pairs (comn) do
local cont = redis:hget(msg.chat_id..':warn', v)
t = t..k..'- '..v..' Warn : '..(cont - 1)..'\n'
end
t = t.."\n\n• برای دیدن کاربر از دستور زیر استفاده کنید!\nچه کسی ایدی\nمثال ! \nچه کسی 363936960"
if #comn == 0 then
t = 'لیست مورد نظر خالی میباشد'
end 
sendText(msg.chat_id, msg.id,t, 'md')
end
if cerner and cerner:match('^unban (%d+)') then
local user_id = cerner:match('^unban (%d+)')
if tonumber(user_id) == tonumber(TD_ID) then
sendText(msg.chat_id, msg.id,  'اوه شت :( \nمن نمیتوانم پیام خودم را چک کنم', 'md')
return false
end
redis:srem('BanUser:'..msg.chat_id,user_id)
RemoveFromBanList(msg.chat_id,user_id)
SendMetion(msg.chat_id,user_id, msg.id, "• User "..(user_id or 021).." Has Been UnBanned", 7,string.len(user_id))
end
if cerner and cerner:match('^حذف بن (%d+)') then
local user_id = cerner:match('^unban (%d+)')
if tonumber(user_id) == tonumber(TD_ID) then
sendText(msg.chat_id, msg.id,  'اوه شت :( \nمن نمیتوانم پیام خودم را چک کنم', 'md')
return false
end
redis:srem('BanUser:'..msg.chat_id,user_id)
RemoveFromBanList(msg.chat_id,user_id)
SendMetion(msg.chat_id,user_id, msg.id, "• کاربر "..(user_id or 021).." از محرومیت گروه آزاد شد", 7,string.len(user_id))
end
if cerner and cerner:match('^ban (%d+)') then
local user_id = cerner:match('^ban (%d+)')
if tonumber(user_id) == tonumber(TD_ID) then
sendText(msg.chat_id, msg.id,"اوه شت :( \nمن نمیتوانم خودم را مسدود کنم",  'md' )
return false
end
if private(msg.chat_id,user_id) then
print '                     Private                          '
sendText(msg.chat_id, msg.id, "اوه شت :(\nمن نمیتوانم یک کاربر دارای مقام را مسدود کنم", 'md')
else
redis:sadd('BanUser:'..msg.chat_id,user_id)
KickUser(msg.chat_id,user_id)
sendText(msg.chat_id, msg.id, '• User `'..user_id..'` Has Been Banned ..!*', 'md')
SendMetion(msg.chat_id,user_id, msg.id, "• User "..(user_id or 021).." Has Been Banned", 7,string.len(user_id))
end
end
if cerner and cerner:match('^بن (%d+)') then
local user_id = cerner:match('^بن (%d+)')
if tonumber(user_id) == tonumber(TD_ID) then
sendText(msg.chat_id, msg.id,"اوه شت :( \nمن نمیتوانم خودم را مسدود کنم",  'md' )
return false
end
if private(msg.chat_id,user_id) then
print '                     Private                          '
sendText(msg.chat_id, msg.id, "اوه شت :(\nمن نمیتوانم یک کاربر دارای مقام را مسدود کنم", 'md')
else
redis:sadd('BanUser:'..msg.chat_id,user_id)
KickUser(msg.chat_id,user_id)
sendText(msg.chat_id, msg.id, '• User `'..user_id..'` Has Been Banned ..!*', 'md')
SendMetion(msg.chat_id,user_id, msg.id, "• کاربر "..(user_id or 021).." از گروه محروم شد", 7,string.len(user_id))
end
end
if cerner and cerner:match('^unban @(.*)') then
local username = cerner:match('unban @(.*)')
function UnBanByUserName(CerNer,Company)
if tonumber(Company.id) == tonumber(TD_ID) then
sendText(msg.chat_id, msg.id,  'اوه شت :( \nمن نمیتوانم پیام خودم را چک کنم', 'md')
return false
end
if Company.id then
print('UserID : '..Company.id..'\nUserName : @'..username)
redis:srem('BanUser:'..msg.chat_id,Company.id)
SendMetion(msg.chat_id,Company.id, msg.id, "• User "..(Company.id or 021).." Has Been UnBanned", 7,string.len(Company.id))
else 
sendText(msg.chat_id, msg.id, '• User Not Found',  'md')

end
print('Send')
end
resolve_username(username,UnBanByUserName)
end
if cerner and cerner:match('^حذف بن @(.*)') then
local username = cerner:match('حذف بن @(.*)')
function UnBanByUserName(CerNer,Company)
if tonumber(Company.id) == tonumber(TD_ID) then
sendText(msg.chat_id, msg.id,  'اوه شت :( \nمن نمیتوانم پیام خودم را چک کنم', 'md')
return false
end
if Company.id then
print('UserID : '..Company.id..'\nUserName : @'..username)
redis:srem('BanUser:'..msg.chat_id,Company.id)
SendMetion(msg.chat_id,Company.id, msg.id, "• کاربر "..(Company.id or 021).." از محرومیت گروه آزاد شد", 7,string.len(Company.id))
else 
sendText(msg.chat_id, msg.id, '• کاربر یافت نشد',  'md')

end
print('Send')
end
resolve_username(username,UnBanByUserName)
end
if cerner == 'unban' and tonumber(msg.reply_to_message_id) > 0 then
function UnBan_by_reply(CerNer,Company)
if tonumber(Company.sender_user_id or 00000000) == tonumber(TD_ID) then
sendText(msg.chat_id, msg.id,  'اوه شت :( \nمن نمیتوانم پیام خودم را چک کنم', 'md')
return false
end
redis:srem('BanUser:'..msg.chat_id,Company.sender_user_id or 00000000)
SendMetion(msg.chat_id,Company.sender_user_id, msg.id, "• User "..(Company.sender_user_id or 021).." Has Been UnBanned", 7,string.len(Company.sender_user_id))
RemoveFromBanList(msg.chat_id,Company.sender_user_id)
 end
getMessage(msg.chat_id, tonumber(msg.reply_to_message_id),UnBan_by_reply)
end
if cerner == 'حذف بن' and tonumber(msg.reply_to_message_id) > 0 then
function UnBan_by_reply(CerNer,Company)
if tonumber(Company.sender_user_id or 00000000) == tonumber(TD_ID) then
sendText(msg.chat_id, msg.id,  'اوه شت :( \nمن نمیتوانم پیام خودم را چک کنم', 'md')
return false
end
redis:srem('BanUser:'..msg.chat_id,Company.sender_user_id or 00000000)
SendMetion(msg.chat_id,Company.sender_user_id, msg.id, "• کاربر "..(Company.sender_user_id or 021).."از محرومیت گروه آزاد شد", 7,string.len(Company.sender_user_id))
RemoveFromBanList(msg.chat_id,Company.sender_user_id)
 end
getMessage(msg.chat_id, tonumber(msg.reply_to_message_id),UnBan_by_reply)
end
if cerner and cerner:match('^ban @(.*)') then
local username = cerner:match('^ban @(.*)')
print '                     Private                          '
function BanByUserName(CerNer,Company)
if tonumber(Company.id) == tonumber(TD_ID) then
sendText(msg.chat_id, msg.id,"اوه شت :( \nمن نمیتوانم خودم را مسدود کنم",  'md' )
return false
end
if private(msg.chat_id,Company.id) then
print '                     Private                          '
sendText(msg.chat_id, msg.id, "اوه شت :(\nمن نمیتوانم یک کاربر دارای مقام را مسدود کنم", 'md')
else
if Company.id then
redis:sadd('BanUser:'..msg.chat_id,Company.id)
KickUser(msg.chat_id,Company.id)
SendMetion(msg.chat_id,Company.id, msg.id, "• User "..(Company.id or 021).." Has Been Banned", 7,string.len(Company.id))
else 
t = '• User Not Found'
sendText(msg.chat_id, msg.id, t,  'md')
end
end
end
resolve_username(username,BanByUserName)
end
if cerner and cerner:match('^بن @(.*)') then
local username = cerner:match('^بن @(.*)')
print '                     Private                          '
function BanByUserName(CerNer,Company)
if tonumber(Company.id) == tonumber(TD_ID) then
sendText(msg.chat_id, msg.id,"اوه شت :( \nمن نمیتوانم خودم را مسدود کنم",  'md' )
return false
end
if private(msg.chat_id,Company.id) then
print '                     Private                          '
sendText(msg.chat_id, msg.id, "اوه شت :(\nمن نمیتوانم یک کاربر دارای مقام را مسدود کنم", 'md')
else
if Company.id then
redis:sadd('BanUser:'..msg.chat_id,Company.id)
KickUser(msg.chat_id,Company.id)
SendMetion(msg.chat_id,Company.id, msg.id, "• کاربر "..(Company.id or 021).." از گروه محروم شد", 7,string.len(Company.id))
else 
t = '• کاربر یافت نشد'
sendText(msg.chat_id, msg.id, t,  'md')
end
end
end
resolve_username(username,BanByUserName)
end
if cerner== 'kick' and tonumber(msg.reply_to_message_id) > 0 then
function kick_by_reply(CerNer,Company)
if tonumber(Company.sender_user_id or 00000000) == tonumber(TD_ID) then
sendText(msg.chat_id, msg.id,"اوه شت :( \nمن نمیتوانم خودم را اخراج کنم",  'md' )
return false
end
if private(msg.chat_id,Company.sender_user_id or 000000000000000000000000000000000000000000000000) then
print '                     Private                          '
sendText(msg.chat_id, msg.id, "اوه شت :(\nمن نمیتوانم یک فرد دارای مقام را اخراج کنم", 'md')
else
SendMetion(msg.chat_id,Company.sender_user_id, msg.id, "• User "..(Company.sender_user_id or 021).." Has Been Kicked", 7,string.len(Company.sender_user_id))
KickUser(msg.chat_id,Company.sender_user_id)
RemoveFromBanList(msg.chat_id,Company.sender_user_id)
 end
end
getMessage(msg.chat_id, tonumber(msg.reply_to_message_id),kick_by_reply)
end
if cerner== 'اخراج' and tonumber(msg.reply_to_message_id) > 0 then
function kick_by_reply(CerNer,Company)
if tonumber(Company.sender_user_id or 00000000) == tonumber(TD_ID) then
sendText(msg.chat_id, msg.id,"اوه شت :( \nمن نمیتوانم خودم را اخراج کنم",  'md' )
return false
end
if private(msg.chat_id,Company.sender_user_id or 000000000000000000000000000000000000000000000000) then
print '                     Private                          '
sendText(msg.chat_id, msg.id, "اوه شت :(\nمن نمیتوانم یک فرد دارای مقام را اخراج کنم", 'md')
else
SendMetion(msg.chat_id,Company.sender_user_id, msg.id, "• کاربر "..(Company.sender_user_id or 021).." از گروه اخراج شد", 7,string.len(Company.sender_user_id))
KickUser(msg.chat_id,Company.sender_user_id)
RemoveFromBanList(msg.chat_id,Company.sender_user_id)
 end
end
getMessage(msg.chat_id, tonumber(msg.reply_to_message_id),kick_by_reply)
end
if cerner and cerner:match('^kick @(.*)') then
local username = cerner:match('^kick @(.*)')
function KickByUserName(CerNer,Company)
if tonumber(Company.id) == tonumber(TD_ID) then
sendText(msg.chat_id, msg.id,"اوه شت :( \nمن نمیتوانم خودم را اخراج کنم",  'md' )
return false
end
if private(msg.chat_id,Company.id or 000000000000000000000000000000000000000000000000) then
print '                     Private                          '
sendText(msg.chat_id, msg.id, "اوه شت :(\nمن نمیتوانم یک فرد دارای مقام را اخراج کنم", 'md')
else
if Company.id then
KickUser(msg.chat_id,Company.id)
RemoveFromBanList(msg.chat_id,Company.id)
SendMetion(msg.chat_id,Company.id, msg.id, "• User "..(Company.id or 021).." Has Been Kicked", 7,string.len(Company.id))
else 
txtt = '• User Not Found'
sendText(msg.chat_id, msg.id,txtt,  'md')
end
end
end
resolve_username(username,KickByUserName)
end
if cerner and cerner:match('^اخراج @(.*)') then
local username = cerner:match('^اخراج @(.*)')
function KickByUserName(CerNer,Company)
if tonumber(Company.id) == tonumber(TD_ID) then
sendText(msg.chat_id, msg.id,"اوه شت :( \nمن نمیتوانم خودم را اخراج کنم",  'md' )
return false
end
if private(msg.chat_id,Company.id or 000000000000000000000000000000000000000000000000) then
print '                     Private                          '
sendText(msg.chat_id, msg.id, "اوه شت :(\nمن نمیتوانم یک فرد دارای مقام را اخراج کنم", 'md')
else
if Company.id then
KickUser(msg.chat_id,Company.id)
RemoveFromBanList(msg.chat_id,Company.id)
SendMetion(msg.chat_id,Company.id, msg.id, "• کاربر "..(Company.id or 021).." از گروه اخراج شد", 7,string.len(Company.id))
else 
txtt = '• کاربر یافت نشد'
sendText(msg.chat_id, msg.id,txtt,  'md')
end
end
end
resolve_username(username,KickByUserName)
end
if cerner == 'clean restricts' or cerner == 'پاکسازی کابران محدود' then
local function pro(arg,data)
if redis:get("Check:Restricted:"..msg.chat_id) then
text = 'هر 5دقیقه یکبار ممکن است'
end
for k,v in pairs(data.members) do
redis:del('MuteAll:'..msg.chat_id)
 mute(msg.chat_id, v.user_id,'Restricted',    {1, 1, 1, 1, 1,1})
   redis:setex("Check:Restricted:"..msg.chat_id,350,true)
end
end
getChannelMembers(msg.chat_id,"Recent", 0, 100000000000,pro)
sendText(msg.chat_id, msg.id,'افراد محدود پاک شدند • ' ,'md')
end 
if cerner and cerner:match('^kick (%d+)') then
local user_id = cerner:match('^kick (%d+)')
if tonumber(user_id) == tonumber(TD_ID) then
sendText(msg.chat_id, msg.id,"اوه شت :( \nمن نمیتوانم خودم را اخراج کنم",  'md' )
return false
end
if private(msg.chat_id,user_id or 000000000000000000000000000000000000000000000000) then
print '                     Private                          '
sendText(msg.chat_id, msg.id, "اوه شت :(\nمن نمیتوانم یک فرد دارای مقام را اخراج کنم", 'md')
else
KickUser(msg.chat_id,user_id)
text= '• User '..user_id..' Has Been Kicked'
SendMetion(msg.chat_id,user_id, msg.id, text,7, string.len(user_id))
RemoveFromBanList(msg.chat_id,user_id)
end
end
if cerner and cerner:match('^اخراج (%d+)') then
local user_id = cerner:match('^اخراج (%d+)')
if tonumber(user_id) == tonumber(TD_ID) then
sendText(msg.chat_id, msg.id,"اوه شت :( \nمن نمیتوانم خودم را اخراج کنم",  'md' )
return false
end
if private(msg.chat_id,user_id or 000000000000000000000000000000000000000000000000) then
print '                     Private                          '
sendText(msg.chat_id, msg.id, "اوه شت :(\nمن نمیتوانم یک فرد دارای مقام را اخراج کنم", 'md')
else
KickUser(msg.chat_id,user_id)
text= '• کاربر '..user_id..' از گروه اخراج شد'
SendMetion(msg.chat_id,user_id, msg.id, text,7, string.len(user_id))
RemoveFromBanList(msg.chat_id,user_id)
end
end
if cerner and cerner:match('^setflood (%d+)') then
local num = cerner:match('^setflood (%d+)')
if tonumber(num) < 2 then
sendText(msg.chat_id, msg.id, '• `Select a number greater than` *2*','md')
else
redis:set('Flood:Max:'..msg.chat_id,num)
sendText(msg.chat_id, msg.id, '• `Flood Sensitivity Has Been Set to` *'..num..'*', 'md')
end
end
if cerner and cerner:match('^تنظیم پیام رگباری (%d+)') then
local num = cerner:match('^تنظیم پیام رگباری (%d+)')
if tonumber(num) < 2 then
sendText(msg.chat_id, msg.id, '• لطفا عددی بزرگتر از 2 انتخاب کنید','md')
else
redis:set('Flood:Max:'..msg.chat_id,num)
sendText(msg.chat_id, msg.id, '• `حساسیت پیام رگباری تنظیم شد بر روی *'..num..'*', 'md')
end
end
if cerner and cerner:match('^warnmax (%d+)') then
local num = cerner:match('^warnmax (%d+)')
if tonumber(num) < 2 then
sendText(msg.chat_id, msg.id, '• `Select a number greater than` *2*','md')
else
redis:set('Warn:Max:'..msg.chat_id,num)
sendText(msg.chat_id, msg.id, '• `Max Warn Has Been Set to` *'..num..'*', 'md')
end
end
if cerner and cerner:match('^حداکثر اخطار (%d+)') then
local num = cerner:match('^حداکثر اخطار (%d+)')
if tonumber(num) < 2 then
sendText(msg.chat_id, msg.id, '• لطفا عددی بزرگتر از 2 انتخاب کنید','md')
else
redis:set('Warn:Max:'..msg.chat_id,num)
sendText(msg.chat_id, msg.id, '• `حداکثر اخطار تنظیم شد بر روی *'..num..'*', 'md')
end
end
if cerner and cerner:match('^setspam (%d+)') then
local num = cerner:match('^setspam (%d+)')
if tonumber(num) < 40 then
sendText(msg.chat_id, msg.id, '• `Select a number greater than` *40*','md')
else
if tonumber(num) > 4096 then
sendText(msg.chat_id, msg.id, '• `Select a number Smaller than` * 4096 * ','md')
else
redis:set('NUM_CH_MAX:'..msg.chat_id,num)
sendText(msg.chat_id, msg.id, '• `Spam` *Sensitivity* `has been set to ` *'..num..'*', 'md')
end
end
end
if cerner and cerner:match('^تنظیم اسپم (%d+)') then
local num = cerner:match('^تنظیم اسپم (%d+)')
if tonumber(num) < 40 then
sendText(msg.chat_id, msg.id, '• `لطفا عددی بزرگتر از 40 انتخاب کنید','md')
else
if tonumber(num) > 4096 then
sendText(msg.chat_id, msg.id, '• `لطفا عددی کوچیکتر از 4096 انتخاب کنید ','md')
else
redis:set('NUM_CH_MAX:'..msg.chat_id,num)
sendText(msg.chat_id, msg.id, '• حساسیت اسپم تنظیم شد بر روی ` *'..num..'*', 'md')
end
end
end
if cerner and cerner:match('^setfloodtime (%d+)') then
local num = cerner:match('^setfloodtime (%d+)')
if tonumber(num) < 1 then
sendText(msg.chat_id, msg.id, '• `Select a number greater than` *1*','md')
else
redis:set('Flood:Time:'..msg.chat_id,num)
sendText(msg.chat_id, msg.id, '• `Flood time change to` *'..num..'*', 'md')
end
end
if cerner and cerner:match('^تنظیم زمان پیام رگباری (%d+)') then
local num = cerner:match('^تنظیم زمان پیام رگباری (%d+)')
if tonumber(num) < 1 then
sendText(msg.chat_id, msg.id, '• لطفا عددی بزرگتر از 1 انتخاب کنید','md')
else
redis:set('Flood:Time:'..msg.chat_id,num)
sendText(msg.chat_id, msg.id, '• زمان پیام رگباری تنظیم شد بر روی'..num..'*', 'md')
end
end
if cerner and cerner:match('^rmsg (%d+)$') then
local limit = tonumber(cerner:match('^rmsg (%d+)$'))
if limit > 100 then
sendText(msg.chat_id, msg.id, '*عددی بین * [`1-100`] را انتخاب کنید', 'md')
else
local function cb(arg,data)
for k,v in pairs(data.messages) do
deleteMessages(msg.chat_id,{[0] =v.id})
end
end
getChatHistory(msg.chat_id,msg.id, 0,  limit,cb)
sendText(msg.chat_id, msg.id, '• ('..limit..') Msg Has Been Deleted', 'md')
end
end
if cerner and cerner:match('^پاکسازی (%d+)$') then
local limit = tonumber(cerner:match('^rmsg (%d+)$'))
if limit > 100 then
sendText(msg.chat_id, msg.id, '*عددی بین * [`1-100`] را انتخاب کنید', 'md')
else
local function cb(arg,data)
for k,v in pairs(data.messages) do
deleteMessages(msg.chat_id,{[0] =v.id})
end
end
getChatHistory(msg.chat_id,msg.id, 0,  limit,cb)
sendText(msg.chat_id, msg.id, '• ('..limit..') پیام گروه پاک شد', 'md')
end
end
if cerner == 'settings' then
local function GetName(CerNer, Company)
local chat = msg.chat_id
if redis:get('Welcome:'..msg.chat_id) == 'enable' then
welcome = '✔️'
else
welcome = '✖️'
end
if redis:get('Lock:Edit'..chat) then
edit = '✔️'
else
edit = '✖️'
end
if redis:get('Lock:Link'..chat) then
Link = '✔️'
else
Link = '✖️' 
end
if redis:get('Lock:Tag:'..chat) then
tag = '✔️'
else
tag = '✖️' 
end
if redis:get('Lock:HashTag:'..chat) then
hashtag = '✔️'
else
hashtag = '✖️' 
end
if redis:get('Lock:Video_note:'..chat) then
video_note = '✔️'
else
video_note = '✖️' 
end
if redis:get('Lock:Inline:'..chat) then
inline = '✔️'
else
inline = '✖️' 
end
if redis:get("Flood:Status:"..msg.chat_id) then
if redis:get("Flood:Status:"..msg.chat_id) == "kickuser" then
Status = 'Kick User'
elseif redis:get("Flood:Status:"..msg.chat_id) == "muteuser" then
Status = 'Mute User'
end
else
Status = 'Not Set'
end
if redis:get('Lock:Pin:'..chat) then
pin = '✔️'
else
pin = '✖️' 
end
if redis:get('Lock:Forward:'..chat) then
fwd = '✔️'
else
fwd = '✖️' 
end
if redis:get('Lock:Bot:'..chat) then
bot = '✔️'
else
bot = '✖️' 
end
if redis:get('Spam:Lock:'..chat) then
spam = '✔️'
else
spam = '✖️' 
end
if redis:get('Lock:Arabic:'..chat) then
arabic = '✔️'
else
arabic = '✖️' 
end
if redis:get('Lock:English:'..chat) then
en = '✔️'
else
en = '✖️' 
end
if redis:get('Lock:TGservise:'..chat) then
tg = '✔️'
else
tg = '✖️' 
end
if redis:get('Lock:Sticker:'..chat) then
sticker = '✔️'
else
sticker = '✖️' 
end
if redis:get('CheckBot:'..msg.chat_id) then
TD = ' Enable'
else
TD = ' Disable'
end
-------------------------------------------
---------Mute Settings----------------------
if redis:get('Mute:Text:'..msg.chat_id) then
txts = '✔️'
else
txts = '✖️'
end
if redis:get('Mute:Contact:'..msg.chat_id) then
contact = '✔️'
else
contact = '✖️'
end
if redis:get('Mute:Document:'..msg.chat_id) then
document = '✔️'
else
document = '✖️'
end
if redis:get('Mute:Location:'..msg.chat_id) then
location = '✔️'
else
location = '✖️'
end
if redis:get('Mute:Voice:'..msg.chat_id) then
voice = '✔️'
else
voice = '✖️'
end
if redis:get('Mute:Photo:'..msg.chat_id) then
photo = '✔️'
else
photo = '✖️'
end
if redis:get('Mute:Game:'..msg.chat_id) then
game = '✔️'
else
game = '✖️'
end
if redis:get('MuteAll:'..chat) then
muteall = '✔️'
else
muteall = '✖️' 
end
if redis:get('Lock:Flood:'..msg.chat_id) then
flood = '✔️'
else
flood = '✖️'
end
if redis:get('Mute:Video:'..msg.chat_id) then
video = '✔️'
else
video = '✖️'
end
if redis:get('Mute:Music:'..msg.chat_id) then
music = '✔️'
else
music = '✖️'
end
if redis:get('Mute:Gif:'..msg.chat_id) then
gif = '✔️'
else
gif = '✖️'
end
local expire = redis:ttl("ExpireData:"..msg.chat_id)
if expire == -1 then
EXPIRE = "نامحدود"
else
local d = math.floor(expire / day ) + 1
EXPIRE = d.."  Day"
end
------------------------More Settings-------------------------
local Text = '•• `SHADOBAKER `\n\n*TD Bot* : `'..TD..'`\n\n*🔰Settings For* `'..Company.title..'🔰`\n\n*🎯Links *↬` '..Link..'`\n*🎯Edit* ↬ `'..edit..'`\n*🎯Tag ↬* `'..tag..'`\n*🎯HashTag ↬ *`'..hashtag..'`\n*🎯Inline ↬ *`'..inline..'`\n*🎯Video Note ↬* `'..video_note..'`\n*🎯Pin ↬* `'..pin..'`\n*🎯Bots ↬ *`'..bot..'`\n*🎯Forward ↬* `'..fwd..'`\n*🎯Arabic ↬ *`'..arabic..'`\n*🎯English ↬* `'..en..'`\n*🎯Tgservise ↬* `'..tg..'`\n*🎯Sticker ↬ *`'..sticker..'`\n\n_🎯Media Settings_ \n\n*🎯Photo ↬* `'..photo..'`\n*🎯Music ↬ *`'..music..'`\n*🎯Voice ↬ *`'..voice..'`\n*🎯Docoment ↬*`'..document..'`\n*🎯Video ↬ *`'..video..'`\n*🎯Gif ↬ *`'..gif..'`\n*🎯Game ↬*`'..game..'`\n*🎯Location ↬ *`'..location..'`\n*🎯Contact ↬ *`'..contact..'`\n*🎯Text ↬*`'..txts..'`\n*🎯All* ↬ `'..muteall..'`\n\n_🎯More Locks_\n\n*🎯Spam ↬ *`'..spam..'`\n*🎯Flood ↬* `'..flood..'`\n*🎯Flood Stats ↬* `'..Status..'`\n*🎯Max Flood ↬* `'..NUM_MSG_MAX..'`\n*🎯Spam Sensitivity ↬ *`'..NUM_CH_MAX..'`\n*🎯Flood Time ↬* `'..TIME_CHECK..'`\n*🎯Warn Max ↬* `'..warn..'`\n\n*🎯Expire ↬* `'..EXPIRE..'`\n*🎯Welcome ↬* `'..welcome..'`\n\n🎯Channel ↬ '
sendText(msg.chat_id, msg.id, Text, 'md')
end
GetChat(msg.chat_id,GetName)
end
--------------------------------------------------
if cerner == 'تنظیمات' then
local function GetName(CerNer, Company)
local chat = msg.chat_id
if redis:get('Welcome:'..msg.chat_id) == 'enable' then
welcome = '✔️'
else
welcome = '✖️'
end
if redis:get('Lock:Edit'..chat) then
edit = '✔️'
else
edit = '✖️'
end
if redis:get('Lock:Link'..chat) then
Link = '✔️'
else
Link = '✖️' 
end
if redis:get('Lock:Tag:'..chat) then
tag = '✔️'
else
tag = '✖️' 
end
if redis:get('Lock:HashTag:'..chat) then
hashtag = '✔️'
else
hashtag = '✖️' 
end
if redis:get('Lock:Video_note:'..chat) then
video_note = '✔️'
else
video_note = '✖️' 
end
if redis:get('Lock:Inline:'..chat) then
inline = '✔️'
else
inline = '✖️' 
end
if redis:get("Flood:Status:"..msg.chat_id) then
if redis:get("Flood:Status:"..msg.chat_id) == "kickuser" then
Status = 'اخراج'
elseif redis:get("Flood:Status:"..msg.chat_id) == "muteuser" then
Status = 'سکوت'
end
else
Status = 'تنظیم نیست'
end
if redis:get('Lock:Pin:'..chat) then
pin = '✔️'
else
pin = '✖️' 
end
if redis:get('Lock:Forward:'..chat) then
fwd = '✔️'
else
fwd = '✖️' 
end
if redis:get('Lock:Bot:'..chat) then
bot = '✔️'
else
bot = '✖️' 
end
if redis:get('Spam:Lock:'..chat) then
spam = '✔️'
else
spam = '✖️' 
end
if redis:get('Lock:Arabic:'..chat) then
arabic = '✔️'
else
arabic = '✖️' 
end
if redis:get('Lock:English:'..chat) then
en = '✔️'
else
en = '✖️' 
end
if redis:get('Lock:TGservise:'..chat) then
tg = '✔️'
else
tg = '✖️' 
end
if redis:get('Lock:Sticker:'..chat) then
sticker = '✔️'
else
sticker = '✖️' 
end
if redis:get('CheckBot:'..msg.chat_id) then
TD = ' فعال'
else
TD = 'غیرفعال'
end
-------------------------------------------
---------Mute Settings----------------------
if redis:get('Mute:Text:'..msg.chat_id) then
txts = '✔️'
else
txts = '✖️'
end
if redis:get('Mute:Contact:'..msg.chat_id) then
contact = '✔️'
else
contact = '✖️'
end
if redis:get('Mute:Document:'..msg.chat_id) then
document = '✔️'
else
document = '✖️'
end
if redis:get('Mute:Location:'..msg.chat_id) then
location = '✔️'
else
location = '✖️'
end
if redis:get('Mute:Voice:'..msg.chat_id) then
voice = '✔️'
else
voice = '✖️'
end
if redis:get('Mute:Photo:'..msg.chat_id) then
photo = '✔️'
else
photo = '✖️'
end
if redis:get('Mute:Game:'..msg.chat_id) then
game = '✔️'
else
game = '✖️'
end
if redis:get('MuteAll:'..chat) then
muteall = '✔️'
else
muteall = '✖️' 
end
if redis:get('Lock:Flood:'..msg.chat_id) then
flood = '✔️'
else
flood = '✖️'
end
if redis:get('Mute:Video:'..msg.chat_id) then
video = '✔️'
else
video = '✖️'
end
if redis:get('Mute:Music:'..msg.chat_id) then
music = '✔️'
else
music = '✖️'
end
if redis:get('Mute:Gif:'..msg.chat_id) then
gif = '✔️'
else
gif = '✖️'
end
local expire = redis:ttl("ExpireData:"..msg.chat_id)
if expire == -1 then
EXPIRE = "نامحدود"
else
local d = math.floor(expire / day ) + 1
EXPIRE = d.."  روز"
end
------------------------More Settings-------------------------
local Text = '•• *TD Bot* : `'..TD..'`\n\n*🔰تنظیمات گروه* `'..Company.title..'🔰`\n\n*🎯لینک *↫` '..Link..'`\n*🎯ویرایش* ↫ `'..edit..'`\n*🎯تگ ↫* `'..tag..'`\n*🎯هشتگ ↫ *`'..hashtag..'`\n*🎯کیبورد شیشه ای ↫ *`'..inline..'`\n*🎯فیلم سلفی ↫* `'..video_note..'`\n*🎯سنجاق ↫* `'..pin..'`\n*🎯ربات ها ↫ *`'..bot..'`\n*🎯فروارد ↫* `'..fwd..'`\n*🎯عربی/فارسی ↫ *`'..arabic..'`\n*🎯انگلیسی ↫* `'..en..'`\n*🎯خدمات تلگرام ↫* `'..tg..'`\n*🎯استیکر ↫ *`'..sticker..'`\n\n_🎯تنظیمات رسانه_ \n\n*🎯عکس ↫* `'..photo..'`\n*🎯اهنگ ↫ *`'..music..'`\n*🎯ویس ↫ *`'..voice..'`\n*🎯اسناد ↫*`'..document..'`\n*🎯فیلم ↫ *`'..video..'`\n*🎯گیف ↫*`'..gif..'`\n*🎯بازی ↫*`'..game..'`\n*🎯موقعیت مکانی ↫ *`'..location..'`\n*🎯مخاطب ↫ *`'..contact..'`\n*🎯متن ↫*`'..txts..'`\n*🎯همه* ↫ `'..muteall..'`\n\n_🎯تنظیمات بیشتر_\n\n*🎯اسپم ↫ *`'..spam..'`\n*🎯پیام رگباری ↫* `'..flood..'`\n*🎯وضعیت پیام رگباری ↫* `'..Status..'`\n*🎯حساسیت پیام رگباری ↫* `'..NUM_MSG_MAX..'`\n*🎯حساسیت اسپم ↫ *`'..NUM_CH_MAX..'`\n*زمان پیام رگباری ↫* `'..TIME_CHECK..'`\n*🎯حداکثر اخطار ↫* `'..warn..'`\n\n*🎯تاریخ انقضا ↫* `'..EXPIRE..'`\n*🎯خوش امد ↫* `'..welcome..'`\n\n🎯کانال ما ↫ '
sendText(msg.chat_id, msg.id, Text, 'md')
end
GetChat(msg.chat_id,GetName)
end
---------------------Welcome----------------------
if cerner == 'welcome enable' then
if redis:get('Welcome:'..msg.chat_id) == 'enable' then
sendText(msg.chat_id, msg.id,'• *Welcome* is _Already_ Enable\n\n' ,'md')
else
sendText(msg.chat_id, msg.id,'• *Welcome* Has Been Enable\n\n' ,'md')
redis:del('Welcome:'..msg.chat_id,'disable')
redis:set('Welcome:'..msg.chat_id,'enable')

end
end
if cerner == 'welcome disable' then
if redis:get('Welcome:'..msg.chat_id) then
sendText(msg.chat_id, msg.id,'• *Welcome* Has Been Disable\n\n' ,'md')
redis:set('Welcome:'..msg.chat_id,'disable')
redis:del('Welcome:'..msg.chat_id,'enable')
else
sendText(msg.chat_id, msg.id,'• *Welcome* is _Already_ Disable\n\n' ,'md')
end
end
---------------------------------------------------------
if cerner == 'خوش امد فعال' then
if redis:get('Welcome:'..msg.chat_id) == 'enable' then
sendText(msg.chat_id, msg.id,'• *خوش امد گویی از قبل فعال بود*\n\n' ,'md')
else
sendText(msg.chat_id, msg.id,'• *خوش امد گویی فعال شد*\n\n' ,'md')
redis:del('Welcome:'..msg.chat_id,'disable')
redis:set('Welcome:'..msg.chat_id,'enable')

end
end
if cerner == 'خوش امد غیرفعال' then
if redis:get('Welcome:'..msg.chat_id) then
sendText(msg.chat_id, msg.id,'• *خوش امد گویی غیرفعال شد*\n\n' ,'md')
redis:set('Welcome:'..msg.chat_id,'disable')
redis:del('Welcome:'..msg.chat_id,'enable')
else
sendText(msg.chat_id, msg.id,'• *خوش امد گویی غیرفعال بود*\n\n' ,'md')
end
end
---------------------------------------------------------
-----------------------------------------------Locks------------------------------------------------------------
-----------------Lock Link--------------------
if cerner == 'lock link' then
if redis:get('Lock:Link'..msg.chat_id) then
sendText(msg.chat_id, msg.id, '• `Lock` *Link*  is _Already_ `Enable`\n\n' , 'md')
else
sendText(msg.chat_id, msg.id, '• `Lock` *Link* `Has Been Enable`\n\n' , 'md')
redis:set('Lock:Link'..msg.chat_id,true)
end
end
if cerner == 'unlock link' then
if redis:get('Lock:Link'..msg.chat_id) then
sendText(msg.chat_id, msg.id, '• `Lock` *Link* `Has Been Disable`\n\n' , 'md')
redis:del('Lock:Link'..msg.chat_id)
else
sendText(msg.chat_id, msg.id, '• `Lock` *Link*  is _Already_  `Disable`\n\n' , 'md')
end
end
if cerner == 'قفل لینک' then
if redis:get('Lock:Link'..msg.chat_id) then
sendText(msg.chat_id, msg.id, '• قفل لینک از قبل فعال بود\n\n' , 'md')
else
sendText(msg.chat_id, msg.id, '• قفل لینک فعال شد\n\n' , 'md')
redis:set('Lock:Link'..msg.chat_id,true)
end
end
if cerner == 'باز لینک' then
if redis:get('Lock:Link'..msg.chat_id) then
sendText(msg.chat_id, msg.id, '• قفل لینک غیرفعال شد\n\n' , 'md')
redis:del('Lock:Link'..msg.chat_id)
else
sendText(msg.chat_id, msg.id, '• قفل لینک از قبل غیرفعال بود\n\n' , 'md')
end
end
---------------------------------------------
if cerner == 'lock tag' then
if redis:get('Lock:Tag:'..msg.chat_id) then
sendText(msg.chat_id, msg.id, '• `Lock` *Tag*  is _Already_ `Enable`\n\n' , 'md')
else
sendText(msg.chat_id, msg.id, '• `Lock` *Tag* `Has Been Enable`\n\n' , 'md')
redis:set('Lock:Tag:'..msg.chat_id,true)
end
end
if cerner == 'unlock tag' then
if redis:get('Lock:Tag:'..msg.chat_id) then
sendText(msg.chat_id, msg.id, '• `Lock` *Tag* `Has Been Disable`\n\n' , 'md')
redis:del('Lock:Tag:'..msg.chat_id)
else
sendText(msg.chat_id, msg.id, '• `Lock` *Tag*  is _Already_  `Disable`\n\n' , 'md')
end
end
if cerner == 'قفل تگ' then
if redis:get('Lock:Tag:'..msg.chat_id) then
sendText(msg.chat_id, msg.id, '• قفل تگ از قبل فعال بود\n\n' , 'md')
else
sendText(msg.chat_id, msg.id, '• قفل تگ فعال شد\n\n' , 'md')
redis:set('Lock:Tag:'..msg.chat_id,true)
end
end
if cerner == 'باز تگ' then
if redis:get('Lock:Tag:'..msg.chat_id) then
sendText(msg.chat_id, msg.id, '• قفل تگ غیرفعال شد\n\n' , 'md')
redis:del('Lock:Tag:'..msg.chat_id)
else
sendText(msg.chat_id, msg.id, '• قفل تگ از قبل غیرفعال بود\n\n' , 'md')
end
end
--------------------------------------------
if cerner == 'lock hashtag' then
if redis:get('Lock:HashTag:'..msg.chat_id) then
sendText(msg.chat_id, msg.id, '• `Lock` *HadshTag*  is _Already_ `Enable`\n\n' , 'md')
else 
sendText(msg.chat_id, msg.id, '• `Lock` *HashTag* `Has Been Enable`\n\n' , 'md')
redis:set('Lock:HashTag:'..msg.chat_id,true)
end
end
if cerner == 'unlock hashtag' then
if redis:get('Lock:HashTag:'..msg.chat_id) then
sendText(msg.chat_id, msg.id, '• `Lock` *HashTag* `Has Been Disable`\n\n' , 'md')
redis:del('Lock:HashTag:'..msg.chat_id)
else
sendText(msg.chat_id, msg.id, '• `Lock` *HashTag*  is _Already_  `Disable`\n\n' , 'md')
end
end
if cerner == 'قفل هشتگ' then
if redis:get('Lock:HashTag:'..msg.chat_id) then
sendText(msg.chat_id, msg.id, '• قفل هشتگ از قبل فعال بود\n\n' , 'md')
else 
sendText(msg.chat_id, msg.id, '• قفل هشتگ فعال شد\n\n' , 'md')
redis:set('Lock:HashTag:'..msg.chat_id,true)
end
end
if cerner == 'باز هشتگ' then
if redis:get('Lock:HashTag:'..msg.chat_id) then
sendText(msg.chat_id, msg.id, '• قفل هشتگ غیرفعال شد\n\n' , 'md')
redis:del('Lock:HashTag:'..msg.chat_id)
else
sendText(msg.chat_id, msg.id, '• قفل هشتگ از قبل غیرفعال بود\n\n' , 'md')
end
end
-----------------------------------------------
if cerner == 'lock video_note' then
if redis:get('Lock:Video_note:'..msg.chat_id) then
sendText(msg.chat_id, msg.id, '• `Lock` *Video note*  is _Already_ `Enable`\n\n' , 'md')
else
sendText(msg.chat_id, msg.id, '• `Lock` *Video note* `Has Been Enable`\n\n' , 'md')
redis:set('Lock:Video_note:'..msg.chat_id,true)
end
end
if cerner == 'unlock vide_onote' then
if redis:get('Lock:Video_note:'..msg.chat_id) then
sendText(msg.chat_id, msg.id, '• `Lock` *Video note* `Has Been Disable`\n\n' , 'md')
redis:del('Lock:Video_note:'..msg.chat_id)
else
sendText(msg.chat_id, msg.id, '• `Lock` *Video note*  is _Already_  `Disable`\n\n' , 'md')
end
end
if cerner == 'قفل فیلم سلفی' then
if redis:get('Lock:Video_note:'..msg.chat_id) then
sendText(msg.chat_id, msg.id, '• قفل فیلم سلفی از قبل فعال بود\n\n' , 'md')
else
sendText(msg.chat_id, msg.id, '• قفل فیلم سلفی فعال شد\n\n' , 'md')
redis:set('Lock:Video_note:'..msg.chat_id,true)
end
end
if cerner == 'باز فیلم سلفی' then
if redis:get('Lock:Video_note:'..msg.chat_id) then
sendText(msg.chat_id, msg.id, '• قفل فلیم سلفی غیرفعال شد\n\n' , 'md')
redis:del('Lock:Video_note:'..msg.chat_id)
else
sendText(msg.chat_id, msg.id, '• قفل فیلم سلفی از قبل غیرفعال بود\n\n' , 'md')
end
end
-------------------------------------------------
if cerner == 'lock spam' then
if redis:get('Spam:Lock:'..msg.chat_id) then
sendText(msg.chat_id, msg.id, '• `Lock` *Spam*  is _Already_ `Enable`\n\n' , 'md')
else
sendText(msg.chat_id, msg.id, '• `Lock` *Spam* `Has Been Enable`\n\n' , 'md')
redis:set('Spam:Lock:'..msg.chat_id,true)
end
end
if cerner == 'unlock spam' then
if redis:get('Spam:Lock:'..msg.chat_id) then
sendText(msg.chat_id, msg.id, '• `Lock` *Spam* `Has Been Disable`\n\n' , 'md')
redis:del('Spam:Lock:'..msg.chat_id)
else
sendText(msg.chat_id, msg.id, '• `Lock` *Spam*  is _Already_  `Disable`\n\n' , 'md')
end
end
if cerner == 'قفل اسپم' then
if redis:get('Spam:Lock:'..msg.chat_id) then
sendText(msg.chat_id, msg.id, '• قفل اسپم از قبل فعال بود\n\n' , 'md')
else
sendText(msg.chat_id, msg.id, '• قفل اسپم فعال شد\n\n' , 'md')
redis:set('Spam:Lock:'..msg.chat_id,true)
end
end
if cerner == 'باز اسپم' then
if redis:get('Spam:Lock:'..msg.chat_id) then
sendText(msg.chat_id, msg.id, '• قفل اسپم غیرفعال شد\n\n' , 'md')
redis:del('Spam:Lock:'..msg.chat_id)
else
sendText(msg.chat_id, msg.id, '• قفل اسپم از قبل غیرفعال بود\n\n' , 'md')
end
end
----------------------------------
if cerner == 'lock inline' then
if redis:get('Lock:Inline:'..msg.chat_id) then
sendText(msg.chat_id, msg.id, '• `Lock` *Inline*  is _Already_ `Enable`\n\n' , 'md')
else
sendText(msg.chat_id, msg.id, '• `Lock` *Inline* `Has Been Enable`\n\n' , 'md')
redis:set('Lock:Inline:'..msg.chat_id,true)
end
end
if cerner == 'unlock inline' then
if redis:get('Lock:Inline:'..msg.chat_id) then
sendText(msg.chat_id, msg.id, '• `Lock` *Inline* `Has Been Disable`\n\n' , 'md')
redis:del('Lock:Inline:'..msg.chat_id)
else
sendText(msg.chat_id, msg.id, '• `Lock` *Inline*  is _Already_  `Disable`\n\n' , 'md')
end
end
if cerner == 'قفل کیبورد شیشه ای' then
if redis:get('Lock:Inline:'..msg.chat_id) then
sendText(msg.chat_id, msg.id, '• قفل کیبورد شیشه ای از قبل فعال بود\n\n' , 'md')
else
sendText(msg.chat_id, msg.id, '• قفل کیبورد شیشه ای فعال شد\n\n' , 'md')
redis:set('Lock:Inline:'..msg.chat_id,true)
end
end
if cerner == 'باز کیبورد شیشه ای' then
if redis:get('Lock:Inline:'..msg.chat_id) then
sendText(msg.chat_id, msg.id, '• قفل کیبورد شیشه ای غیرفعال شد\n\n' , 'md')
redis:del('Lock:Inline:'..msg.chat_id)
else
sendText(msg.chat_id, msg.id, '• قفل کیبورد شیشه ای از قبل غیرفعال بود\n\n' , 'md')
end
end
-----------------------------------------------
if cerner == 'lock pin' then
if redis:get('Lock:Pin:'..msg.chat_id) then
sendText(msg.chat_id, msg.id, '• `Lock` *Pin*  is _Already_ `Enable`\n\n' , 'md')
else
sendText(msg.chat_id, msg.id, '• `Lock` *Pin* `Has Been Enable`\n\n' , 'md')
redis:set('Lock:Pin:'..msg.chat_id,true)
end
end
if cerner == 'unlock pin' then
if redis:get('Lock:pin:'..msg.chat_id) then
sendText(msg.chat_id, msg.id, '• `Lock` *Pin* `Has Been Disable`\n\n' , 'md')
else
sendText(msg.chat_id, msg.id, '• `Lock` *Pin*  is _Already_  `Disable`\n\n' , 'md')
redis:del('Lock:Pin:'..msg.chat_id)
end
end
if cerner == 'قفل سنجاق' then
if redis:get('Lock:Pin:'..msg.chat_id) then
sendText(msg.chat_id, msg.id, '• قفل سنجاق از قبل فعال بود\n\n' , 'md')
else
sendText(msg.chat_id, msg.id, '• قفل سنجاق فعال شد\n\n' , 'md')
redis:set('Lock:Pin:'..msg.chat_id,true)
end
end
if cerner == 'باز سنجاق' then
if redis:get('Lock:pin:'..msg.chat_id) then
sendText(msg.chat_id, msg.id, '• قفل سنجاق غیرفعال شد\n\n' , 'md')
else
sendText(msg.chat_id, msg.id, '• قفل سنجاق از قبل غیرفعال بود\n\n' , 'md')
redis:del('Lock:Pin:'..msg.chat_id)
end
end
-----------------------------------------------
if cerner == 'lock flood' then
if redis:get('Lock:Flood:'..msg.chat_id) then
sendText(msg.chat_id, msg.id, '• `Lock` *Flood*  is _Already_ `Enable`\n\n' , 'md')
else
sendText(msg.chat_id, msg.id, '• `Lock` *Flood* `Has Been Enable`\n\n' , 'md')
redis:set('Lock:Flood:'..msg.chat_id,true)
end
end
if cerner == 'unlock flood' then
if redis:get('Lock:Flood:'..msg.chat_id) then
sendText(msg.chat_id, msg.id, '• `Lock` *Flood* `Has Been Disable`\n\n' , 'md')
redis:del('Lock:Flood:'..msg.chat_id)
else
sendText(msg.chat_id, msg.id, '• `Lock` *Flood*  is _Already_  `Disable`\n\n' , 'md')
end
end
if cerner == 'قفل پیام مکرر' then
if redis:get('Lock:Flood:'..msg.chat_id) then
sendText(msg.chat_id, msg.id, '• قفل پیام مکرر از قبل فعال بود\n\n' , 'md')
else
sendText(msg.chat_id, msg.id, '• قفل پیام مکرر فعال شد\n\n' , 'md')
redis:set('Lock:Flood:'..msg.chat_id,true)
end
end
if cerner == 'باز پیام مکرر' then
if redis:get('Lock:Flood:'..msg.chat_id) then
sendText(msg.chat_id, msg.id, '• قفل پیام مکرر غیرفعال شد\n\n' , 'md')
redis:del('Lock:Flood:'..msg.chat_id)
else
sendText(msg.chat_id, msg.id, '• قفل پیام مکرر از قبل غیرفعال بود\n\n' , 'md')
end
end
----------------------------------------------
if cerner == 'lock forward' then
if redis:get('Lock:Forward:'..msg.chat_id) then
sendText(msg.chat_id, msg.id, '• `Lock` *Forward*  is _Already_ `Enable`\n\n' , 'md')
else
sendText(msg.chat_id, msg.id, '• `Lock` *Forward* `Has Been Enable`\n\n' , 'md')
redis:set('Lock:Forward:'..msg.chat_id,true)
end
end
if cerner == 'unlock forward' then
if redis:get('Lock:Forward:'..msg.chat_id) then
sendText(msg.chat_id, msg.id, '• `Lock` *Forward* `Has Been Disable`\n\n' , 'md')
redis:del('Lock:Forward:'..msg.chat_id)
else
sendText(msg.chat_id, msg.id, '• `Lock` *Forward*  is _Already_  `Disable`\n\n' , 'md')
end
end
if cerner == 'قفل فروارد' then
if redis:get('Lock:Forward:'..msg.chat_id) then
sendText(msg.chat_id, msg.id, '• قفل فروارد از قبل فعال بود\n\n' , 'md')
else
sendText(msg.chat_id, msg.id, '• قفل فروارد فعال شد\n\n' , 'md')
redis:set('Lock:Forward:'..msg.chat_id,true)
end
end
if cerner == 'باز فروارد' then
if redis:get('Lock:Forward:'..msg.chat_id) then
sendText(msg.chat_id, msg.id, '• قفل فروارد غیرفعال شد\n\n' , 'md')
redis:del('Lock:Forward:'..msg.chat_id)
else
sendText(msg.chat_id, msg.id, '• قفل فروارد از قبل غیرفعال بود\n\n' , 'md')
end
end
------------------------------------------------
if cerner == 'lock arabic' then
if redis:get('Lock:Arabic:'..msg.chat_id) then
sendText(msg.chat_id, msg.id, '• `Lock` *Arabic*  is _Already_ `Enable`\n\n' , 'md')
else
sendText(msg.chat_id, msg.id, '• `Lock` *Arabic* `Has Been Enable`\n\n' , 'md')
redis:set('Lock:Arabic:'..msg.chat_id,true)
end
end
if cerner == 'unlock arabic' then
if redis:get('Lock:Arabic:'..msg.chat_id) then
sendText(msg.chat_id, msg.id, '• `Lock` *Arabic* `Has Been Disable`\n\n' , 'md')
redis:del('Lock:Arabic:'..msg.chat_id)
else
sendText(msg.chat_id, msg.id, '• `Lock` *Arabic*  is _Already_  `Disable`\n\n' , 'md')
end
end
if cerner == 'قفل فارسی' then
if redis:get('Lock:Arabic:'..msg.chat_id) then
sendText(msg.chat_id, msg.id, '• قفل فارسی از قبل فعال بود\n\n' , 'md')
else
sendText(msg.chat_id, msg.id, '• قفل فارسی فعال شد\n\n' , 'md')
redis:set('Lock:Arabic:'..msg.chat_id,true)
end
end
if cerner == 'باز فارسی' then
if redis:get('Lock:Arabic:'..msg.chat_id) then
sendText(msg.chat_id, msg.id, '• قفل فارسی غیرفعال شد\n\n' , 'md')
redis:del('Lock:Arabic:'..msg.chat_id)
else
sendText(msg.chat_id, msg.id, '• قفل فارسی از قبل غیرفعال بود\n\n' , 'md')
end
end
---------------------------------------------
if cerner == 'lock bot' then
if redis:get('Lock:Bot:'..msg.chat_id) then
sendText(msg.chat_id, msg.id, '• `Lock` *Bot*  is _Already_ `Enable`\n\n' , 'md')
else
sendText(msg.chat_id, msg.id, '• `Lock` *Bot* `Has Been Enable`\n\n' , 'md')
redis:set('Lock:Bot:'..msg.chat_id,true)
end
end
if cerner == 'unlock bot'then
if redis:get('Lock:Bot:'..msg.chat_id) then
sendText(msg.chat_id, msg.id, '• `Lock` *Bot* `Has Been Disable`\n\n' , 'md')
redis:del('Lock:Bot:'..msg.chat_id)
else
sendText(msg.chat_id, msg.id, '• `Lock` *Bot*  is _Already_  `Disable`\n\n' , 'md')
end
end
if cerner == 'قفل ربات' then
if redis:get('Lock:Bot:'..msg.chat_id) then
sendText(msg.chat_id, msg.id, '• قفل ورود ربات از قبل فعال بود\n\n' , 'md')
else
sendText(msg.chat_id, msg.id, '• قفل ورود ربات فعال شد\n\n' , 'md')
redis:set('Lock:Bot:'..msg.chat_id,true)
end
end
if cerner == 'باز ربات'then
if redis:get('Lock:Bot:'..msg.chat_id) then
sendText(msg.chat_id, msg.id, '• قفل ورود ربات غیرفعال شد\n\n' , 'md')
redis:del('Lock:Bot:'..msg.chat_id)
else
sendText(msg.chat_id, msg.id, '• قفل ورود ربات از قبل غیرفعال بود\n\n' , 'md')
end
end
--------------------------------------------
if cerner == 'lock edit' then
if redis:get('Lock:Edit'..msg.chat_id) then
sendText(msg.chat_id, msg.id, '• `Lock` *Edit*  is _Already_ `Enable`\n\n' , 'md')
else
sendText(msg.chat_id, msg.id, '• `Lock` *Edit* `Has Been Enable`\n\n' , 'md')
redis:set('Lock:Edit'..msg.chat_id,true)
end
end
if cerner == 'unlock edit' then
if redis:get('Lock:Edit'..msg.chat_id) then
sendText(msg.chat_id, msg.id, '• `Lock` *Edit* `Has Been Disable`\n\n' , 'md')
redis:del('Lock:Edit'..msg.chat_id)
else
sendText(msg.chat_id, msg.id, '• `Lock` *Edit*  is _Already_  `Disable`\n\n' , 'md')
end
end
if cerner == 'قفل ویرایش' then
if redis:get('Lock:Edit'..msg.chat_id) then
sendText(msg.chat_id, msg.id, '• قفل ویرایش پیام از قبل فعال بود\n\n' , 'md')
else
sendText(msg.chat_id, msg.id, '• قفل ویرایش پیام فعال شد\n\n' , 'md')
redis:set('Lock:Edit'..msg.chat_id,true)
end
end
if cerner == 'باز ویرایش' then
if redis:get('Lock:Edit'..msg.chat_id) then
sendText(msg.chat_id, msg.id, '• قفل ویرایش پیام غیرفعال شد\n\n' , 'md')
redis:del('Lock:Edit'..msg.chat_id)
else
sendText(msg.chat_id, msg.id, '• قفل ویرایش پیام از قبل غیرفعال بود\n\n' , 'md')
end
end
-----------------------------------------------
if cerner == 'lock english' then
if redis:get('Lock:English:'..msg.chat_id) then
sendText(msg.chat_id, msg.id, '• `Lock` *English*  is _Already_ `Enable`\n\n' , 'md')
else
sendText(msg.chat_id, msg.id, '• `Lock` *English* `Has Been Enable`\n\n' , 'md')
redis:set('Lock:English:'..msg.chat_id,true)
end
end
if cerner == 'unlock english' then
if redis:get('Lock:English:'..msg.chat_id) then
sendText(msg.chat_id, msg.id, '• `Lock` *English* `Has Been Disable`\n\n' , 'md')
redis:del('Lock:English:'..msg.chat_id)
else
sendText(msg.chat_id, msg.id, '• `Lock` *Forward*  is _Already_  `Disable`\n\n' , 'md')
end
end
if cerner == 'قفل انگلیسی' then
if redis:get('Lock:English:'..msg.chat_id) then
sendText(msg.chat_id, msg.id, '• قفل نوشتار انگلیسی از قبل غیرفعال بود\n\n' , 'md')
else
sendText(msg.chat_id, msg.id, '• قفل نوشتار انگلیسی فعال شد\n\n' , 'md')
redis:set('Lock:English:'..msg.chat_id,true)
end
end
if cerner == 'باز انگلیسی' then
if redis:get('Lock:English:'..msg.chat_id) then
sendText(msg.chat_id, msg.id, '• قفل نوشتار انگلیسی غیرفعال شد\n\n' , 'md')
redis:del('Lock:English:'..msg.chat_id)
else
sendText(msg.chat_id, msg.id, '• قفل نوشتار انگلیسی از قبل غیرفعال بود\n\n' , 'md')
end
end
--------------------------------------------
if cerner == 'lock tgservice' then
if redis:get('Lock:TGservise:'..msg.chat_id) then
sendText(msg.chat_id, msg.id, '• `Lock` *TGservise*  is _Already_ `Enable`\n\n' , 'md')
else
sendText(msg.chat_id, msg.id, '• `Lock` *TGservise* `Has Been Enable`\n\n' , 'md')
redis:set('Lock:TGservise:'..msg.chat_id,true)
end
end
if cerner == 'unlock tgservice' then
if redis:get('Lock:TGservise:'..msg.chat_id) then
sendText(msg.chat_id, msg.id, '• `Lock` *TGservise* `Has Been Disable`\n\n' , 'md')
redis:del('Lock:TGservise:'..msg.chat_id)
else
sendText(msg.chat_id, msg.id, '• `Lock` *TGservise*  is _Already_  `Disable`\n\n' , 'md')
end
end
if cerner == 'قفل خدمات تلگرام' then
if redis:get('Lock:TGservise:'..msg.chat_id) then
sendText(msg.chat_id, msg.id, '• قفل خدمات تلگرام از قبل فعال بود\n\n' , 'md')
else
sendText(msg.chat_id, msg.id, '• قفل خدمات تلگرام فعال شد\n\n' , 'md')
redis:set('Lock:TGservise:'..msg.chat_id,true)
end
end
if cerner == 'باز خدمات تلگرام' then
if redis:get('Lock:TGservise:'..msg.chat_id) then
sendText(msg.chat_id, msg.id, '• قفل خدمات تلگرام غیرفعال شد\n\n' , 'md')
redis:del('Lock:TGservise:'..msg.chat_id)
else
sendText(msg.chat_id, msg.id, '• قفل خدمات تلگرام از قبل غیرفعال بود\n\n' , 'md')
end
end
-------------------------------------------
if cerner == 'lock sticker' then
if redis:get('Lock:Sticker:'..msg.chat_id) then
sendText(msg.chat_id, msg.id, '• `Lock` *Sticker*  is _Already_ `Enable`\n\n' , 'md')
else
sendText(msg.chat_id, msg.id, '• `Lock` *Sticker* `Has Been Enable`\n\n' , 'md')
redis:set('Lock:Sticker:'..msg.chat_id,true)
end
end
if cerner == 'unlock sticker' then
if redis:get('Lock:Sticker:'..msg.chat_id) then
sendText(msg.chat_id, msg.id, '• `Lock` *Sticker* `Has Been Disable`\n\n' , 'md')
redis:del('Lock:Sticker:'..msg.chat_id)
else
sendText(msg.chat_id, msg.id, '• `Lock` *Sticker*  is _Already_  `Disable`\n\n' , 'md')
end
end
if cerner == 'قفل استیکر' then
if redis:get('Lock:Sticker:'..msg.chat_id) then
sendText(msg.chat_id, msg.id, '• قفل استیکر از قبل فعال بود\n\n' , 'md')
else
sendText(msg.chat_id, msg.id, '• قفل استیکر فعال شد\n\n' , 'md')
redis:set('Lock:Sticker:'..msg.chat_id,true)
end
end
if cerner == 'باز استیکر' then
if redis:get('Lock:Sticker:'..msg.chat_id) then
sendText(msg.chat_id, msg.id, '• قفل استیکر غیرفعال شدn\n' , 'md')
redis:del('Lock:Sticker:'..msg.chat_id)
else
sendText(msg.chat_id, msg.id, '• قفل استیکر از قبل غیرفعال بود\n\n' , 'md')
end
end
--------------------------------------------
-------------------------Mutes-----------------------------------------
if cerner == 'lock text' then
if redis:get('Mute:Text:'..msg.chat_id) then
sendText(msg.chat_id, msg.id, '• `Lock` *Text*  is _Already_ `Enable`\n\n' , 'md')
else
sendText(msg.chat_id, msg.id, '• `Lock` *Text* `Has Been Enable`\n\n' , 'md')
redis:set('Mute:Text:'..msg.chat_id,true)
end
end
if cerner == 'unlock text' then
if redis:get('Mute:Text:'..msg.chat_id) then
sendText(msg.chat_id, msg.id, '• `Lock` *Text* `Has Been Disable`\n\n' , 'md')
redis:del('Mute:Text:'..msg.chat_id)
else
sendText(msg.chat_id, msg.id, '• `Lock` *Text*  is _Already_  `Disable`\n\n' , 'md')
end
end
if cerner == 'قفل متن' then
if redis:get('Mute:Text:'..msg.chat_id) then
sendText(msg.chat_id, msg.id, '• قفل متن از قبل فعال بود\n\n' , 'md')
else
sendText(msg.chat_id, msg.id, '• قفل متن فعال شد\n\n' , 'md')
redis:set('Mute:Text:'..msg.chat_id,true)
end
end
if cerner == 'باز متن' then
if redis:get('Mute:Text:'..msg.chat_id) then
sendText(msg.chat_id, msg.id, '• قفل متن غیرفعال شد\n\n' , 'md')
redis:del('Mute:Text:'..msg.chat_id)
else
sendText(msg.chat_id, msg.id, '• قفل متن از قبل غیرفعال بود\n\n' , 'md')
end
end
---------------------------------------------------------------------------------
if cerner == 'lock contact' then
if redis:get('Mute:Contact:'..msg.chat_id) then
sendText(msg.chat_id, msg.id, '• `Lock` *Contact*  is _Already_ `Enable`\n\n' , 'md')
else
sendText(msg.chat_id, msg.id, '• `Lock` *Contact* `Has Been Enable`\n\n' , 'md')
redis:set('Mute:Contact:'..msg.chat_id,true)
end
end
if cerner == 'unlock contact' then
if redis:get('Mute:Contact:'..msg.chat_id) then
sendText(msg.chat_id, msg.id, '• `Lock` *Contact* `Has Been Disable`\n\n' , 'md')
redis:del('Mute:Contact:'..msg.chat_id)
else
sendText(msg.chat_id, msg.id, '• `Lock` *Contact*  is _Already_  `Disable`\n\n' , 'md')
end
end
if cerner == 'قفل مخاطب' then
if redis:get('Mute:Contact:'..msg.chat_id) then
sendText(msg.chat_id, msg.id, '• قفل مخاطب از قبل فعال بود\n\n' , 'md')
else
sendText(msg.chat_id, msg.id, '• قفل مخاطب قعال شد\n\n' , 'md')
redis:set('Mute:Contact:'..msg.chat_id,true)
end
end
if cerner == 'باز مخاطب' then
if redis:get('Mute:Contact:'..msg.chat_id) then
sendText(msg.chat_id, msg.id, '• قفل مخاطب غیرفعال شد\n\n' , 'md')
redis:del('Mute:Contact:'..msg.chat_id)
else
sendText(msg.chat_id, msg.id, '• قفل مخاطب از قبل غیرفعال بود\n\n' , 'md')
end
end
---------------------------------------------------------------------------------
if cerner == 'lock document' then
if redis:get('Mute:Document:'..msg.chat_id) then
sendText(msg.chat_id, msg.id, '• `Lock` *Document*  is _Already_ `Enable`\n\n' , 'md')
else
sendText(msg.chat_id, msg.id, '• `Lock` *Document* `Has Been Enable`\n\n' , 'md')
redis:set('Mute:Document:'..msg.chat_id,true)
end
end
if cerner == 'unlock document' then
if redis:get('Mute:Document:'..msg.chat_id) then
sendText(msg.chat_id, msg.id, '• `Lock` *Document* `Has Been Disable`\n\n' , 'md')
redis:del('Mute:Document:'..msg.chat_id)
else
sendText(msg.chat_id, msg.id, '• `Lock` *Document*  is _Already_  `Disable`\n\n' , 'md')
end
end
if cerner == 'قفل اسناد' then
if redis:get('Mute:Document:'..msg.chat_id) then
sendText(msg.chat_id, msg.id, '• قفل اسناد از قبل فعال بود\n\n' , 'md')
else
sendText(msg.chat_id, msg.id, '• قفل اسناد فعال شد\n\n' , 'md')
redis:set('Mute:Document:'..msg.chat_id,true)
end
end
if cerner == 'باز اسناد' then
if redis:get('Mute:Document:'..msg.chat_id) then
sendText(msg.chat_id, msg.id, '• قفل اسناد غیرفعال فعال شد\n\n' , 'md')
redis:del('Mute:Document:'..msg.chat_id)
else
sendText(msg.chat_id, msg.id, '• قفل اسناد از قبل غیرفعال بود\n\n' , 'md')
end
end
---------------------------------------------------------------------------------
if cerner == 'lock location' then
if redis:get('Mute:Location:'..msg.chat_id) then
sendText(msg.chat_id, msg.id, '• `Lock` *Location*  is _Already_ `Enable`\n\n' , 'md')
else
sendText(msg.chat_id, msg.id, '• `Lock` *Location* `Has Been Enable`\n\n' , 'md')
redis:set('Mute:Location:'..msg.chat_id,true)
end
end
if cerner == 'unlock location' then
if redis:get('Mute:Location:'..msg.chat_id) then
sendText(msg.chat_id, msg.id, '• `Lock` *Location* `Has Been Disable`\n\n' , 'md')
redis:del('Mute:Location:'..msg.chat_id)
else
sendText(msg.chat_id, msg.id, '• `Lock` *Location*  _is Already_  `Disable`\n\n' , 'md')
end
end
if cerner == 'قفل موقعیت مکانی' then
if redis:get('Mute:Location:'..msg.chat_id) then
sendText(msg.chat_id, msg.id, '• قفل موقعیت مکانی از قبل فعال بود\n\n' , 'md')
else
sendText(msg.chat_id, msg.id, '• قفل موقعیت مکانی فعال شد\n\n' , 'md')
redis:set('Mute:Location:'..msg.chat_id,true)
end
end
if cerner == 'باز موقعیت مکانی' then
if redis:get('Mute:Location:'..msg.chat_id) then
sendText(msg.chat_id, msg.id, '• قفل موقعیت مکانی غیرفعال شد\n\n' , 'md')
redis:del('Mute:Location:'..msg.chat_id)
else
sendText(msg.chat_id, msg.id, '• قفل موقعیت مکانی از قبل غیرفعال بود\n\n' , 'md')
end
end
---------------------------------------------------------------------------------
if cerner == 'lock voice' then
if redis:get('Lock:Voice:'..msg.chat_id) then
sendText(msg.chat_id, msg.id, '• `Lock` *Voice*  is _Already_ `Enable`\n\n' , 'md')
else
sendText(msg.chat_id, msg.id, '• `Lock` *Voice* `Has Been Enable`\n\n' , 'md')
redis:set('Mute:Voice:'..msg.chat_id,true)
end
end
if cerner == 'unlock voice' then
if redis:get('Mute:Voice:'..msg.chat_id) then
sendText(msg.chat_id, msg.id, '• `Lock` *Voice* `Has Been Disable`\n\n' , 'md')
redis:del('Mute:Voice:'..msg.chat_id)
else
sendText(msg.chat_id, msg.id, '• `Lock` *Voice*  _is Already_  `Disable`\n\n' , 'md')
end
end
if cerner == 'قفل ویس' then
if redis:get('Lock:Voice:'..msg.chat_id) then
sendText(msg.chat_id, msg.id, '• قفل ویس از قبل فعال بود\n\n' , 'md')
else
sendText(msg.chat_id, msg.id, '• قفل ویس فعال شد\n\n' , 'md')
redis:set('Mute:Voice:'..msg.chat_id,true)
end
end
if cerner == 'باز ویس' then
if redis:get('Mute:Voice:'..msg.chat_id) then
sendText(msg.chat_id, msg.id, '• قفل ویس غیرفعال شد\n\n' , 'md')
redis:del('Mute:Voice:'..msg.chat_id)
else
sendText(msg.chat_id, msg.id, '• قفل ویس از قبل غیرفعال بود\n\n' , 'md')
end
end
---------------------------------------------------------------------------------
if cerner == 'lock photo' then
if redis:get('Mute:Photo:'..msg.chat_id) then
sendText(msg.chat_id, msg.id, '• `Lock` *Photo*  is _Already_ `Enable`\n\n' , 'md')
else
sendText(msg.chat_id, msg.id, '• `Lock` *Photo* `Has Been Enable`\n\n' , 'md')
redis:set('Mute:Photo:'..msg.chat_id,true)
end
end
if cerner == 'unlock photo' then
if redis:get('Mute:Photo:'..msg.chat_id) then
sendText(msg.chat_id, msg.id, '• `Lock` *Photo* `Has Been Disable`\n\n' , 'md')
redis:del('Mute:Photo:'..msg.chat_id)
else
sendText(msg.chat_id, msg.id, '• `Lock` *Photo*  _is Already_  `Disable`\n\n' , 'md')
end
end
if cerner == 'قفل عکس' then
if redis:get('Mute:Photo:'..msg.chat_id) then
sendText(msg.chat_id, msg.id, '• قفل عکس از قبل فعال بود\n\n' , 'md')
else
sendText(msg.chat_id, msg.id, '• قفل عکس فعال شد\n\n' , 'md')
redis:set('Mute:Photo:'..msg.chat_id,true)
end
end
if cerner == 'باز عکس' then
if redis:get('Mute:Photo:'..msg.chat_id) then
sendText(msg.chat_id, msg.id, '• قفل عکس غیرفعال شد\n\n' , 'md')
redis:del('Mute:Photo:'..msg.chat_id)
else
sendText(msg.chat_id, msg.id, '• قفل عکس از قبل غیرفعال بود\n\n' , 'md')
end
end
---------------------------------------------------------------------------------
if cerner == 'lock game' then
if redis:get('Mute:Game:'..msg.chat_id) then
sendText(msg.chat_id, msg.id, '• `Lock` *Game*  is _Already_ `Enable`\n\n' , 'md')
else
sendText(msg.chat_id, msg.id, '• `Lock` *Game* `Has Been Enable`\n\n' , 'md')
redis:set('Mute:Game:'..msg.chat_id,true)
end
end
if cerner == 'unlock game' then
if redis:get('Mute:Game:'..msg.chat_id) then
sendText(msg.chat_id, msg.id, '• `Lock` *Game* `Has Been Disable`\n\n' , 'md')
redis:del('Mute:Game:'..msg.chat_id)
else
sendText(msg.chat_id, msg.id, '• `Lock` *Game*  _is Already_  `Disable`\n\n' , 'md')
end
end
if cerner == 'قفل بازی' then
if redis:get('Mute:Game:'..msg.chat_id) then
sendText(msg.chat_id, msg.id, '• قفل بازی از قبل فعال بود\n\n' , 'md')
else
sendText(msg.chat_id, msg.id, '• قفل بازی فعال شد\n\n' , 'md')
redis:set('Mute:Game:'..msg.chat_id,true)
end
end
if cerner == 'باز بازی' then
if redis:get('Mute:Game:'..msg.chat_id) then
sendText(msg.chat_id, msg.id, '• قفل بازی غیرفعال شد\n\n' , 'md')
redis:del('Mute:Game:'..msg.chat_id)
else
sendText(msg.chat_id, msg.id, '• قفل بازی از قبل غیرفعال بود\n\n' , 'md')
end
end
---------------------------------------------------------------------------------
if cerner == 'lock video' then
if redis:get('Mute:Video:'..msg.chat_id) then
sendText(msg.chat_id, msg.id, '• `Lock` *Video*  is _Already_ `Enable`\n\n' , 'md')
else
sendText(msg.chat_id, msg.id, '• `Lock` *Video* `Has Been Enable`\n\n' , 'md')
redis:set('Mute:Video:'..msg.chat_id,true)
end
end
if cerner == 'unlock video' then
if redis:get('Mute:Video:'..msg.chat_id) then
sendText(msg.chat_id, msg.id, '• `Lock` *Video* `Has Been Disable`\n\n' , 'md')
redis:del('Mute:Video:'..msg.chat_id)
else
sendText(msg.chat_id, msg.id, '• `Lock` *Video*  _is Already_  `Disable`\n\n' , 'md')
end
end
if cerner == 'قفل فیلم' then
if redis:get('Mute:Video:'..msg.chat_id) then
sendText(msg.chat_id, msg.id, '• قفل فیلم از قبل فعال بود\n\n' , 'md')
else
sendText(msg.chat_id, msg.id, '• قفل فیلم فعال شد\n\n' , 'md')
redis:set('Mute:Video:'..msg.chat_id,true)
end
end
if cerner == 'باز فیلم' then
if redis:get('Mute:Video:'..msg.chat_id) then
sendText(msg.chat_id, msg.id, '• قفل فیلم غیرفعال شد\n\n' , 'md')
redis:del('Mute:Video:'..msg.chat_id)
else
sendText(msg.chat_id, msg.id, '• قفل فیلم از قبل غیرفعال بود\n\n' , 'md')
end
end
---------------------------------------------------------------------------------
if cerner == 'lock music' then
if redis:get('Mute:Music:'..msg.chat_id) then
sendText(msg.chat_id, msg.id, '• `Lock` *Music*  is _Already_ `Enable`\n\n' , 'md')
else
sendText(msg.chat_id, msg.id, '• `Lock` *Music* `Has Been Enable`\n\n' , 'md')
redis:set('Mute:Music:'..msg.chat_id,true)
end
end
if cerner == 'unlock music' then
if redis:get('Mute:Music:'..msg.chat_id) then
sendText(msg.chat_id, msg.id, '• `Lock` *Music* `Has Been Disable`\n\n' , 'md')
redis:del('Mute:Music:'..msg.chat_id)
else
sendText(msg.chat_id, msg.id, '• `Lock` *Music*  _is Already_  `Disable`\n\n' , 'md')
end
end
if cerner == 'قفل اهنگ' then
if redis:get('Mute:Music:'..msg.chat_id) then
sendText(msg.chat_id, msg.id, '• قفل اهنگ از قبل فعال بود\n\n' , 'md')
else
sendText(msg.chat_id, msg.id, '• قفل اهنگ فعال شد\n\n' , 'md')
redis:set('Mute:Music:'..msg.chat_id,true)
end
end
if cerner == 'باز اهنگ' then
if redis:get('Mute:Music:'..msg.chat_id) then
sendText(msg.chat_id, msg.id, '• قفل اهنگ غیرفعال شد\n\n' , 'md')
redis:del('Mute:Music:'..msg.chat_id)
else
sendText(msg.chat_id, msg.id, '• قفل اهنگ از قبل غیرفعال بود\n\n' , 'md')
end
end
---------------------------------------------------------------------------------
if cerner == 'lock gif' then
if redis:get('Mute:Gif:'..msg.chat_id) then
sendText(msg.chat_id, msg.id, '• `Lock` *Gif*  is _Already_ `Enable`\n\n' , 'md')
else
sendText(msg.chat_id, msg.id, '• `Lock` *Gif* `Has Been Enable`\n\n' , 'md')
redis:set('Mute:Gif:'..msg.chat_id,true)
end
end
if cerner == 'unlock gif' then
if redis:get('Mute:Gif:'..msg.chat_id) then
sendText(msg.chat_id, msg.id, '• `Lock` *Gif* `Has Been Disable`\n\n' , 'md')
redis:del('Mute:Gif:'..msg.chat_id)
else
sendText(msg.chat_id, msg.id, '• `Lock` *Gif*  _is Already_  `Disable`\n\n' , 'md')
end
end
if cerner == 'قفل گیف' then
if redis:get('Mute:Gif:'..msg.chat_id) then
sendText(msg.chat_id, msg.id, '• قفل گیف از قبل فعال بود\n\n' , 'md')
else
sendText(msg.chat_id, msg.id, '• قفل گیف فعال شد\n\n' , 'md')
redis:set('Mute:Gif:'..msg.chat_id,true)
end
end
if cerner == 'باز گیف' then
if redis:get('Mute:Gif:'..msg.chat_id) then
sendText(msg.chat_id, msg.id, '• قفل گیف غیرفعال شد\n\n' , 'md')
redis:del('Mute:Gif:'..msg.chat_id)
else
sendText(msg.chat_id, msg.id, '• قفل گیف از قبل غیرفعال شد\n\n' , 'md')
end
end
-----------End Mutes---------------
----------------------------------------------------------------------------------
if cerner1 and cerner1:match('^[Ss]etlink (.*)') then
local link = cerner1:match('^[Ss]etlink (.*)')
redis:set('Link:'..msg.chat_id,link)
sendText(msg.chat_id, msg.id,'• *New Link Has Been Seted*\n\n', 'md')
end
if cerner1 and cerner1:match('^[Ss]etwelcome (.*)') then
local wel = cerner1:match('^[Ss]etwelcome (.*)')
redis:set('Text:Welcome:'..msg.chat_id,wel)
sendText(msg.chat_id, msg.id,'• *New Welcome Has Been Seted*\n\n', 'md')
end
if cerner1 and cerner1:match('^[Ss]etrules (.*)') then
local rules = cerner1:match('^[Ss]etrules (.*)')
redis:set('Rules:'..msg.chat_id,rules)
sendText(msg.chat_id, msg.id,'• *New rules Has Been Seted*\n\n', 'md')
end

if cerner1 and cerner1:match('^تنظیم لینک (.*)') then
local link = cerner1:match('^تنظیم لینک (.*)')
redis:set('Link:'..msg.chat_id,link)
sendText(msg.chat_id, msg.id,'• *لینک جدید ثبت شد*\n\n', 'md')
end
if cerner1 and cerner1:match('^تنظیم خوش امد (.*)') then
local wel = cerner1:match('^تنظیم خوش امد (.*)')
redis:set('Text:Welcome:'..msg.chat_id,wel)
sendText(msg.chat_id, msg.id,'• *پیام خوش امد تنظیم شد*\n\n', 'md')
end
if cerner1 and cerner1:match('^تنظیم قوانین (.*)') then
local rules = cerner1:match('^تنظیم قوانین (.*)')
redis:set('Rules:'..msg.chat_id,rules)
sendText(msg.chat_id, msg.id,'• *پیام قوانین تنظیم شد*\n\n', 'md')
end
-----------------------------------------------------------------------------------------------------------------------------------------------------
if cerner and cerner:match('^filter +(.*)') then
local word = cerner:match('^filter +(.*)')
redis:sadd('Filters:'..msg.chat_id,word)
sendText(msg.chat_id, msg.id, '• `'..word..'` *Added To BadWord List!*', 'md')
end

if cerner and cerner:match('^فیلتر +(.*)') then
local word = cerner:match('^فیلتر +(.*)')
redis:sadd('Filters:'..msg.chat_id,word)
sendText(msg.chat_id, msg.id, '•کلمه `'..word..'` *به لیست فیلتر اضافه شد!*', 'md')
end

if cerner and cerner:match('^remfilter +(.*)') then
local word = cerner:match('^remfilter +(.*)')
redis:srem('Filters:'..msg.chat_id,word)
sendText(msg.chat_id, msg.id,'• `'..word..'` *Removed From BadWord List!*', 'md')
end
if cerner and cerner:match('^حذف فیلتر +(.*)') then
local word = cerner:match('^حذف فیلتر +(.*)')
redis:srem('Filters:'..msg.chat_id,word)
sendText(msg.chat_id, msg.id,'•کلمه `'..word..'` *از لیست فیلتر حذف شد!*', 'md')
end
if cerner == "warn" and tonumber(msg.reply_to_message_id) > 0 then
function WarnByReply(CerNer,Company)
if tonumber(Company.sender_user_id or 00000000) == tonumber(TD_ID) then
sendText(msg.chat_id, msg.id,  'اوه شت :( \nمن نمیتوانم پیام خودم را چک کنم', 'md')
return false
end
if private(msg.chat_id,Company.sender_user_id or 00000000) then
print '                     Private                          '
sendText(msg.chat_id, msg.id, "اوه شت :(\nمن نمیتوانم به یک فرد دارای مقام اخطار بدهم", 'md')
else
 local hashwarn = msg.chat_id..':warn'
local warnhash = redis:hget(msg.chat_id..':warn',(Company.sender_user_id or 00000000)) or 1
if tonumber(warnhash) == tonumber(warn) then
KickUser(msg.chat_id,Company.sender_user_id)
RemoveFromBanList(msg.chat_id,Company.sender_user_id)
text= "User  *"..(Company.sender_user_id or 00000000).."* has been *kicked because max warning \nNumber of warn :*"..warnhash.."/"..warn..""
redis:hdel(hashwarn,Company.sender_user_id, '0')
SendMetion(msg.chat_id,Company.sender_user_id, msg.id, text, 7, string.len(Company.sender_user_id))
else
local warnhash = redis:hget(msg.chat_id..':warn',(Company.sender_user_id or 00000000)) or 1
 redis:hset(hashwarn,Company.sender_user_id, tonumber(warnhash) + 1)
text= "کاربر  "..(Company.sender_user_id or '0000Null0000').." شما یک اخطار دریافت کردید\nتعداد اخطار های شما : "..warnhash.."/"..warn..""
SendMetion(msg.chat_id,Company.sender_user_id, msg.id, text, 7, string.len(Company.sender_user_id))
end
end
 end
getMessage(msg.chat_id, tonumber(msg.reply_to_message_id),WarnByReply)
end
if cerner == "اخطار" and tonumber(msg.reply_to_message_id) > 0 then
function WarnByReply(CerNer,Company)
if tonumber(Company.sender_user_id or 00000000) == tonumber(TD_ID) then
sendText(msg.chat_id, msg.id,  'اوه شت :( \nمن نمیتوانم پیام خودم را چک کنم', 'md')
return false
end
if private(msg.chat_id,Company.sender_user_id or 00000000) then
print '                     Private                          '
sendText(msg.chat_id, msg.id, "اوه شت :(\nمن نمیتوانم به یک فرد دارای مقام اخطار بدهم", 'md')
else
 local hashwarn = msg.chat_id..':warn'
local warnhash = redis:hget(msg.chat_id..':warn',(Company.sender_user_id or 00000000)) or 1
if tonumber(warnhash) == tonumber(warn) then
KickUser(msg.chat_id,Company.sender_user_id)
RemoveFromBanList(msg.chat_id,Company.sender_user_id)
text= "کاربر  *"..(Company.sender_user_id or 00000000).."* به دلیل اخطار بیش از حد اخراج شد \nتعداد اخطار های شما :*"..warnhash.."/"..warn..""
redis:hdel(hashwarn,Company.sender_user_id, '0')
SendMetion(msg.chat_id,Company.sender_user_id, msg.id, text, 7, string.len(Company.sender_user_id))
else
local warnhash = redis:hget(msg.chat_id..':warn',(Company.sender_user_id or 00000000)) or 1
 redis:hset(hashwarn,Company.sender_user_id, tonumber(warnhash) + 1)
text= "کاربر  "..(Company.sender_user_id or '0000Null0000').." شما یک اخطار دریافت کردید\nتعداد اخطار های شما : "..warnhash.."/"..warn..""
SendMetion(msg.chat_id,Company.sender_user_id, msg.id, text, 7, string.len(Company.sender_user_id))
end
end
 end
getMessage(msg.chat_id, tonumber(msg.reply_to_message_id),WarnByReply)
end
if cerner == "unwarn" and tonumber(msg.reply_to_message_id) > 0 or cerner == "حذف اخطار" and tonumber(msg.reply_to_message_id) > 0 then
function UnWarnByReply(CerNer,Company)
if tonumber(Company.sender_user_id or 00000000) == tonumber(TD_ID) then
sendText(msg.chat_id, msg.id,  'اوه شت :( \nمن نمیتوانم پیام خودم را چک کنم', 'md')
    return false
    end
  if private(msg.chat_id,Company.sender_user_id or 00000000) then
print '                     Private                          '
    else
local warnhash = redis:hget(msg.chat_id..':warn',(Company.sender_user_id or 00000000)) or 1
if tonumber(warnhash) == tonumber(1) then
text= "کاربر  *"..Company.sender_user_id.."* هیچ اخطاری ندارد"
sendText(msg.chat_id, msg.id, text, 'md')
else
local warnhash = redis:hget(msg.chat_id..':warn',(Company.sender_user_id or 00000000))
 local hashwarn = msg.chat_id..':warn'
 redis:hdel(hashwarn,(Company.sender_user_id or 00000000),'0')
if Company.username then
    user_name = '@'..check_markdown(Company.username)
       else
    user_name = ec_name(Company.first_name)
   end
text= "کاربر   "..(Company.sender_user_id or '0000Null0000').." تمام اخطار های شما پاک شد "
sendText(msg.chat_id, msg.id, text, 'md')
end
 end
end
getMessage(msg.chat_id, tonumber(msg.reply_to_message_id),UnWarnByReply)
end
------
end
------
if redis:get('CheckBot:'..msg.chat_id) then
if cerner and cerner:match('^id @(.*)') then
local username = cerner:match('^id @(.*)')
 function IdByUserName(CerNer,Company)
if Company.id then
text = '• SHADOBAKER\n\nUser ID : ['..Company.id..']\n\n'
sendText(msg.chat_id, msg.id, text, 'md')
end
end
resolve_username(username,IdByUserName)
 end

 if redis:get('CheckBot:'..msg.chat_id) then
if cerner and cerner:match('^ایدی @(.*)') then
local username = cerner:match('^ایدی @(.*)')
 function IdByUserName(CerNer,Company)
if Company.id then
text = '• SHADOBAKER\n\nشناسه کاربر : ['..Company.id..']\n\n'
sendText(msg.chat_id, msg.id, text, 'md')
end
end
resolve_username(username,IdByUserName)
 end
 
if cerner == 'id' then
function GetID(CerNer, Company)
 local user = Company.sender_user_id
local text = 'SHADOBAKER\n'..Company.sender_user_id
SendMetion(msg.chat_id,Company.sender_user_id, msg.id, text, 16, string.len(Company.sender_user_id))
end
if tonumber(msg.reply_to_message_id) == 0 then
else
getMessage(msg.chat_id, tonumber(msg.reply_to_message_id),GetID)
end
end
if cerner == 'ایدی' then
function GetID(CerNer, Company)
 local user = Company.sender_user_id
local text = 'SHADOBAKER\n'..Company.sender_user_id
SendMetion(msg.chat_id,Company.sender_user_id, msg.id, text, 16, string.len(Company.sender_user_id))
end
if tonumber(msg.reply_to_message_id) == 0 then
else
getMessage(msg.chat_id, tonumber(msg.reply_to_message_id),GetID)
end
end
if cerner and cerner:match('^getpro (%d+)') or cerner and cerner:match('^عکس پروفایل (%d+)') then
local offset = tonumber(cerner:match('^getpro (%d+)'))
local offset = tonumber(cerner:match('^عکس پروفایل (%d+)'))
if offset > 50 then
sendText(msg.chat_id, msg.id,'اوه شت :( \n من بیشتر از 50 عکس پروفایل شما را نمیتوانم ارسال کنم • ','md')
elseif offset < 1 then
sendText(msg.chat_id, msg.id, 'لطفا عددی بزرگتر از 0  بکار ببرید • ', 'md')
else
function GetPro1(CerNer, Company)
 if Company.photos[0] then
sendPhoto(msg.chat_id, msg.id, 0, 1, nil, Company.photos[0].sizes[2].photo.persistent_id,'• Total Profile Photos : '..Company.total_count..'\n• Photo Size : '.. Company.photos[0].sizes[2].photo.size)
else
sendText(msg.chat_id, msg.id, 'شما عکس پروفایل '..offset..' ندارید', 'md')
end
end
tdbot_function ({_ ="getUserProfilePhotos", user_id = msg.sender_user_id, offset = offset-1, limit = 100000000000000000000000 },GetPro1, nil)
end
end
if cerner and cerner:match('^whois (%d+)') then
local id = tonumber(cerner:match('^whois (%d+)'))
local function Whois(CerNer,Company)
 if Company.first_name then
local username = ec_name(Company.first_name)
SendMetion(msg.chat_id,Company.id, msg.id,username,0,utf8.len(username))

else
sendText(msg.chat_id, msg.id,'*User  ['..id..'] Not Found*','md')
end
end
GetUser(id,Whois)
end
if cerner and cerner:match('^چی کسی (%d+)') then
local id = tonumber(cerner:match('^چه کسی (%d+)'))
local function Whois(CerNer,Company)
 if Company.first_name then
local username = ec_name(Company.first_name)
SendMetion(msg.chat_id,Company.id, msg.id,username,0,utf8.len(username))

else
sendText(msg.chat_id, msg.id,'*کاربر  ['..id..'] یافت نشد*','md')
end
end
GetUser(id,Whois)
end
 if cerner == "id"  then 
if tonumber(msg.reply_to_message_id) == 0  then 
 function GetPro(CerNer, Company)
Msgs = redis:get('Total:messages:'..msg.chat_id..':'..(msg.sender_user_id or 00000000))
if is_sudo(msg) then
rank =  ''..(redis:get('rank'..msg.sender_user_id) or "Sudo")..'' 
elseif is_Owner(msg) then
rank =  ''..(redis:get('rank'..msg.sender_user_id) or "Owner")..'' 
elseif is_Mod(msg) then
rank =  ''..(redis:get('rank'..msg.sender_user_id) or "ADMIN")..''
elseif is_Vip(msg) then
rank =  ''..(redis:get('rank'..msg.sender_user_id) or "VIP")..''
elseif not is_Mod(msg) then
rank = ''..(redis:get('rank'..msg.sender_user_id) or "Member")..''
end
 if Company.photos[0] then
print('persistent_id : '..Company.photos[0].sizes[2].photo.persistent_id)  
sendPhoto(msg.chat_id, msg.id, 0, 1, nil, Company.photos[0].sizes[2].photo.persistent_id,'• SHADOBAKER\n\nChat ID : ['..msg.chat_id..']\nUser ID : ['..msg.sender_user_id..']\nRank : ['..rank..']\nTotal Msgs : '..Msgs..'\nTD ID : '..TD_ID..'\n')
else
sendText(msg.chat_id, msg.id,  '• `SHADOBAKER`!!\n\nChat ID : ['..msg.chat_id..']\nUser ID : ['..msg.sender_user_id..']\nRank : ['..rank..']\nTotal Msgs : '..Msgs..'\nTD ID : '..TD_ID..'\n', 'md')
print '                      Not Photo                      ' 
end
end
tdbot_function ({_ ="getUserProfilePhotos", user_id = (msg.sender_user_id or 00000000), offset =0, limit = 100000000 },GetPro, nil)
end
end
 if cerner == "ایدی"  then 
if tonumber(msg.reply_to_message_id) == 0  then 
 function GetPro(CerNer, Company)
Msgs = redis:get('Total:messages:'..msg.chat_id..':'..(msg.sender_user_id or 00000000))
if is_sudo(msg) then
rank =  ''..(redis:get('rank'..msg.sender_user_id) or "مدیرکل")..'' 
elseif is_Owner(msg) then
rank =  ''..(redis:get('rank'..msg.sender_user_id) or "مالک")..'' 
elseif is_Mod(msg) then
rank =  ''..(redis:get('rank'..msg.sender_user_id) or "مدیر")..''
elseif is_Vip(msg) then
rank =  ''..(redis:get('rank'..msg.sender_user_id) or "عضو ویژه")..''
elseif not is_Mod(msg) then
rank = ''..(redis:get('rank'..msg.sender_user_id) or "کاربر عادی")..''
end
 if Company.photos[0] then
print('persistent_id : '..Company.photos[0].sizes[2].photo.persistent_id)  
sendPhoto(msg.chat_id, msg.id, 0, 1, nil, Company.photos[0].sizes[2].photo.persistent_id,'• SHADOBAKER\n\nشناسه گروه : ['..msg.chat_id..']\nشناسه شما : ['..msg.sender_user_id..']\nمقام شما : ['..rank..']\nتعداد پیام های شما : '..Msgs..'\nشناسه تی دی شما : '..TD_ID..'\n')
else
sendText(msg.chat_id, msg.id,  '• `SHADOBAKER`!!\n\nشناسه گروه : ['..msg.chat_id..']\nشناسه شما : ['..msg.sender_user_id..']\nمقام شما : ['..rank..']\nتعداد پیام های شما : '..Msgs..'\nشناسه تی دی شما : '..TD_ID..'\n', 'md')
print '                      Not Photo                      ' 
end
end
tdbot_function ({_ ="getUserProfilePhotos", user_id = (msg.sender_user_id or 00000000), offset =0, limit = 100000000 },GetPro, nil)
end
end

if cerner == 'me' then
local function GetName(CerNer, Company)
if is_sudo(msg) then
rank =  ''..(redis:get('rank'..msg.sender_user_id) or "Sudo")..'' 
elseif is_Owner(msg) then
rank =  ''..(redis:get('rank'..msg.sender_user_id) or "Owner")..'' 
elseif is_Mod(msg) then
rank =  ''..(redis:get('rank'..msg.sender_user_id) or "ADMIN")..''
elseif is_Vip(msg) then
rank =  ''..(redis:get('rank'..msg.sender_user_id) or "VIP")..''
elseif not is_Mod(msg) then
rank = ''..(redis:get('rank'..msg.sender_user_id) or "Member")..''
end
if Company.first_name then
CompanyName = ec_name(Company.first_name)
else  
CompanyName = '\n\n'
end

Msgs = redis:get('Total:messages:'..msg.chat_id..':'..msg.sender_user_id)
sendText(msg.chat_id, msg.id,  '• `SHADOBAKER!!`\n\n• Your Name : ['..CompanyName..']\n• User ID : ['..msg.sender_user_id..']\n• Rank : ['..rank..']\n• Total Msgs : ['..Msgs..']\n','md')
end
GetUser(msg.sender_user_id,GetName)
end
if cerner == 'من' then
local function GetName(CerNer, Company)
if is_sudo(msg) then
rank =  ''..(redis:get('rank'..msg.sender_user_id) or "مدیرکل")..'' 
elseif is_Owner(msg) then
rank =  ''..(redis:get('rank'..msg.sender_user_id) or "مالک")..'' 
elseif is_Mod(msg) then
rank =  ''..(redis:get('rank'..msg.sender_user_id) or "مدیر")..''
elseif is_Vip(msg) then
rank =  ''..(redis:get('rank'..msg.sender_user_id) or "عضو ویژه")..''
elseif not is_Mod(msg) then
rank = ''..(redis:get('rank'..msg.sender_user_id) or "کاربر عادی")..''
end
if Company.first_name then
CompanyName = ec_name(Company.first_name)
else  
CompanyName = '\n\n'
end

Msgs = redis:get('Total:messages:'..msg.chat_id..':'..msg.sender_user_id)
sendText(msg.chat_id, msg.id,  '• `SHADOBAKER!!`\n\n• نام شما : ['..CompanyName..']\n• شناسه شما : ['..msg.sender_user_id..']\n• مقام شما : ['..rank..']\n• تعداد پیام های شما : ['..Msgs..']\n','md')
end
GetUser(msg.sender_user_id,GetName)
end
if cerner == 'about me' then
function GetName(extra, result, success) 
if result.about then
CompanyName = result.about
else  
CompanyName = 'nil\n\n'
end
if result.common_chat_count  then
Companycommon_chat_count  = result.common_chat_count 
else 
Companycommon_chat_count  = 'nil'
end
sendText(msg.chat_id, msg.id,  '• `SHADOBAKER`!!\n\n• Bio : ['..CompanyName..']\n\nCommon chat count : ['..Companycommon_chat_count..']', 'md')
end
GetUserFull(msg.sender_user_id,GetName)
end
if cerner == 'درباره من' then
function GetName(extra, result, success) 
if result.about then
CompanyName = result.about
else  
CompanyName = 'nil\n\n'
end
if result.common_chat_count  then
Companycommon_chat_count  = result.common_chat_count 
else 
Companycommon_chat_count  = 'nil'
end
sendText(msg.chat_id, msg.id,  '• `SHADOBAKER`!!\n\n• بیوگرافی شما : ['..CompanyName..']\n\nتعداد کروه های مشترک با من : ['..Companycommon_chat_count..']', 'md')
end
GetUserFull(msg.sender_user_id,GetName)
end
if cerner == 'groupinfo' then
 local function FullInfo(CerNer,Company)
sendText(msg.chat_id, msg.id,'*SuperGroup Info :*\n`SuperGroup ID :`*'..msg.chat_id..'*\n`Total Admins :` *'..Company.administrator_count..'*\n`Total Banned :` *'..Company.banned_count..'*\n`Total Members :` *'..Company.member_count..'*\n`About Group :` *'..Company.description..'*\n`Link : `*'..Company.invite_link..'*\n`Total Restricted : `*'..Company.restricted_count..'*', 'md')
end
getChannelFull(msg.chat_id,FullInfo)
end

if cerner == 'اطلاعات گروه' then
 local function FullInfo(CerNer,Company)
sendText(msg.chat_id, msg.id,'*اطلاعات گروه :*\n`شناسه گروه :`*'..msg.chat_id..'*\n`تعداد ادمین ها :` *'..Company.administrator_count..'*\n`تعداد مسدودی ها :` *'..Company.banned_count..'*\n`تعداد ممبر ها :` *'..Company.member_count..'*\n`درباره گروه :` *'..Company.description..'*\n`لینک گروه : `*'..Company.invite_link..'*\n`تعداد کابران محدود شده : `*'..Company.restricted_count..'*', 'md')
end
getChannelFull(msg.chat_id,FullInfo)
end

-------------------------------
end
if cerner == 'link' then
local link = redis:get('Link:'..msg.chat_id) 
if link then
sendText(msg.chat_id,msg.id,  '• *Group Link:*\n'..link..'\n\n', 'md')
else
sendText(msg.chat_id, msg.id, '• *Link Not Set*\n\n', 'md')
end
end
if cerner == 'لینک' then
local link = redis:get('Link:'..msg.chat_id) 
if link then
sendText(msg.chat_id,msg.id,  '• *لینک گروه:*\n'..link..'\n\n', 'md')
else
sendText(msg.chat_id, msg.id, '• *لینک گروه ثبت نشده است*\n\n', 'md')
end
end
if cerner == 'rules' then
local rules = redis:get('Rules:'..msg.chat_id) 
if rules then
sendText(msg.chat_id,msg.id,  '• *Group Rules:*\n'..rules..'\n\n', 'md')
else
sendText(msg.chat_id, msg.id, '• *Rules Not Set*\n\n', 'md')
end
end
if cerner == 'قوانین' then
local rules = redis:get('Rules:'..msg.chat_id) 
if rules then
sendText(msg.chat_id,msg.id,  '• *قوانین گروه:*\n'..rules..'\n\n', 'md')
else
sendText(msg.chat_id, msg.id, '• *قوانین گروه ثبت نشده است*\n\n', 'md')
end
end
if cerner == 'games' then

local games = {'Corsairs','LumberJack','MathBattle'}
sendGame(msg.chat_id, msg.id, 166035794, games[math.random(#games)])
end
if cerner == 'بازی' then

local games = {'Corsairs','LumberJack','MathBattle'}
sendGame(msg.chat_id, msg.id, 166035794, games[math.random(#games)])
end
if cerner == 'ping' then
txts = [[• PONG

]]
sendText(msg.chat_id, msg.id, txts, 'md')
end
if cerner == 'انلاینی' then
txts = [[• آره گلم انلاینم

]]
sendText(msg.chat_id, msg.id, txts, 'md')
end
if cerner == 'help' then
if is_sudo(msg) then
text =[[ •• راهنمای کار با کرنر برای مقام صاحب ربات

• setsudo [user]
> تنظیم کاربر به عنوان کمک مدیر ربات

• remsudo [user]
> حذف کاربر از لیست کمک مدیر ربات 

• add
> افزودن گروه به لیست گروه های مدیریتی 

• rem 
> حذف گروه از لیست گروه های مدیریتی 

• charge [num]
> شارژ گروه به دلخواه

• plan1 [chat_id]
> شارژ گروه به مدت یک ماه 

• plan2 [chat_id]
> شارژ گروه به مدت 2 ماه 

• plan3 [chat_id]
> شارژ گروه به مدت نامحدود 

• leave [chat_id]
> خروج از گروه مورد نظر

• expire 
> مدت شارژ گروه 

•  groups
> نمایش تمام گروه ها 

• banall [user] or [reply] or [username]
> مسدود کردن کاربر مورد نظر از تمام گروها 

• unbanall [user] or [reply] or [username]
> حذف کاربر مورد نظر از لیست مسدودیت

• setowner 
تنظیم کاربر به عنوان صاحب گروه 

• remowner 
> غزل کاربر از مقام صاحب گروه

• ownerlist 
> نمایش لیست صاحبان گروه

• clean ownerlist
> پاکسازی لیست مالکان گروه

• clean gbans
> پاکسازی لیست کاربران لیست سیاه

• clean members 
> پاکسازی تمام کاربران گروه 

• gbans 
> لیست کاربران موجود در لیست سیاه 

• leave 
> خارج کردن ربات از گروه مورد نظر 

• bc [reply]
> ارسال پیام مورد نظر به تمام گرو ها 

• fwd [reply]
> فروارد پیام به تمام گروه ها 

• stats 
> نمایش آمار ربات 

• reload 
> بازنگری ربات 

• git pull 
>  اپدیت ربات به اخرین نسخه 

• welcome enable
> فعال کردن خوش امد گو

• welcome disable
> غیرفعال کردن خوش امد گو

• setwelcome [text]
> تنظیم خوش امد گو
شما میتوانید از 

{first} : بکار بردن نام کاربر
{last} : بکار بردن نام بزرگ 
{username} : بکار بردن یوزرنیم
{rules} : بکار بردن قوانین
}link} : بکار بردن لینک 

مثال :
setwelcome سلام {first} {last} {username} به گروه خوش امدی 

• muteuser [user] or [reply] or [username]
> محدود کردن کاربر  

• unmuteuser [user] or [reply] or [username]
> رفع محدودیت کاربر

• mute all
> محدود کردن تمام کاربران 

• unmute all 
> رفیع محدودیت تمام اعضا 

• setvip [reply] or [username]
> ویژه کردن کاربر 

• remvip [user] or [reply] or [username]
> حذف کاربر از لیست ویژه

• viplist
> نمایش اعضای ویزه 

• clean viplist 
> پاکسازی لیست اعضای ویژه

• clean bots
> اخراج تمامی ربات ها 

• filter [word]
> فیلتر کردن کالمه مورد نظر

• unfilter [word]
> حذف کلمه مورد نظر از لیست فیلتر 

• kick [user] or [reply] or [username]
> اخراج کاربر از گروه 

• ban [user] or [reply] or [username]
> مسدود کردن کاربر از گروه 

• banlist 
> لیست کاربران مسدود شده 

• clean banlist
> حذف کاربران از لیست مسدودین گروه 

• setflood [num]
> تنظیم پیام رگباری

• setflood [kickuser] or [muteuser]
> تنظیم حالت برخورد با پیام رگباری

• setfloodtime [num]
> تنظیم زمان پیام رگباری

• setlink [link] or [reply]
> تنظیم لینک گروه 

• config 
> ارتقا تمام ادمین ها 

• setrules [rules] 
> تنظیم  قوانین گروه 
 
• clean restricts
> حذف کاربران محدود شده  از لیست

 • lock [link]/[spam][edit]/[tag]/[hashtag]/[inline]/[video_note]/[bot]/[forward]/[arabic]/[english]/[tgservice]/[sticker]
قفل کردن  
مثال
lock bot 
قفل ورود ربات

 • unlock [link]/[spam][edit]/[tag]/[hashtag]/[inline]/[video_note]/[bot]/[forward]/[arabic]/[english]/[tgservice]/[sticker]
بازکردن قفل 
مثال : 
unlock bot 

 • mute [photo]/[music]/[voice]/[document]/[video]/[game]/[location]/[contact]/[gif]/[text]
> بیصدا کردن 
مثال : 
mute photo

 • unmute [photo]/[music]/[voice]/[document]/[video]/[game]/[location]/[contact]/[gif]/[text]
> لغو بیصدا 
مثال : 
unmute photo

• warnmax [num]
> تنظیم مقدار اخطار

• warn [user] or [reply] or [username]
> اخطار دادن به کاربر 

• unwarn [reply]
> حذف کاربر

• clean warnlist 
> پاکسازی لیست افرادی که اخطار گرفته اند 

• delall [user] or [reply] or [username] 
> پاکسازی تمام پیام های یک کاربر 

• setname [name]
> تنظیم نام گروه

• setdescription [des]
> تنظیم درباره گروه
]]
elseif is_Owner(msg) then
text =[[•• راهنمای کار با ربات کرنر برای مقام صاحب گروه 
• welcome enable
> فعال کردن خوش امد گو

• welcome disable
> غیرفعال کردن خوش امد گو

• setwelcome [text]
> تنظیم خوش امد گو
شما میتوانید از 

{first} : بکار بردن نام کاربر
{last} : بکار بردن نام بزرگ 
{username} : بکار بردن یوزرنیم
{rules} : بکار بردن قوانین
{link} : بکار بردن لینک


مثال :
setwelcome سلام {first} {last} {username} به گروه خوش امدی 

• whois [user_id]
> نمایش کاربر

• clean mutelist
> خالی کردن لیست افراد صامت شده گروه و ازادسازی ان ها

• promote [user] or [reply] or [username]
> ترفیع دادن کاربر به مقام کمک مدیر

• demote [user] or [reply] or [username]

• pin [reply]
> سنجاق کردن پیام

• unpin
> حذف پیام پین شده 

• muteuser [user] or [reply] or [username]
> محدود کردن کاربر  

• unmuteuser [user] or [reply] or [username]
> رفع محدودیت کاربر

• mute all
> محدود کردن تمام کاربران 

• unmute all 
> رفیع محدودیت تمام اعضا 

• setvip  [reply] or [username]
> ویژه کردن کاربر 

• remvip [user] or [reply] or [username]
> حذف کاربر از لیست ویژه

• viplist
> نمایش اعضای ویزه 

• clean viplist 
> پاکسازی لیست اعضای ویژه

• clean bots
> اخراج تمامی ربات ها 

• filter [word]
> فیلتر کردن کالمه مورد نظر

• unfilter [word]
> حذف کلمه مورد نظر از لیست فیلتر 

• kick [user] or [reply] or [username]
> اخراج کاربر از گروه 

• ban [user] or [reply] or [username]
> مسدود کردن کاربر از گروه 

• banlist 
> لیست کاربران مسدود شده 

• clean banlist
> حذف کاربران از لیست مسدودین گروه 

• setflood [num]
> تنظیم پیام رگباری

• setflood [kickuser] or [muteuser]
> تنظیم حالت برخورد با پیام رگباری

• setfloodtime [num]
> تنظیم زمان پیام رگباری

• setlink [link] or [reply]
> تنظیم لینک گروه 

• config 
> ارتقا تمام ادمین ها 

• setrules [rules] 
> تنظیم  قوانین گروه 
 
• clean restricts
> حذف کاربران محدود شده  از لیست

 • lock [link]/[spam][edit]/[tag]/[hashtag]/[inline]/[video_note]/[pin]/[bot]/[forward]/[arabic]/[english]/[tgservice]/[sticker]
قفل کردن  
مثال
lock bot 
قفل ورود ربات

 • unlock [link]/[spam]/[edit]/[tag]/[hashtag]/[inline]/[video_note]/[pin]/[bot]/[forward]/[arabic]/[english]/[tgservice]/[sticker]
بازکردن قفل 
مثال : 
unlock bot 

 • mute [photo]/[music]/[voice]/[document]/[video]/[game]/[location]/[contact]/[gif]/[text]
> بیصدا کردن 
مثال : 
mute photo

 • unmute [photo]/[music]/[voice]/[document]/[video]/[game]/[location]/[contact]/[gif]/[text]
> لغو بیصدا 
مثال : 
unmute photo

• getpro [num] > limit 50
> دریافت 50 پروفایل خود 

• warnmax [num]
> تنظیم مقدار اخطار

• warn [user] or [reply] or [username]
> اخطار دادن به کاربر 

• unwarn [reply]
> حذف کاربر

• clean warnlist 
> پاکسازی لیست افرادی که اخطار گرفته اند 

• delall [user] or [reply] or [username] 
> پاکسازی تمام پیام های یک کاربر 

• setname [name]
> تنظیم نام گروه

• setdescription [des]
> تنظیم درباره گروه

]]
elseif is_Mod(msg) then
text =[[• • راهنمای کار با کرنر برای مقام کمک مدیر

• welcome enable
> فعال کردن خوش امد گو

• welcome disable
> غیرفعال کردن خوش امد گو

• setwelcome [text]
> تنظیم خوش امد گو
شما میتوانید از 

{first} : بکار بردن نام کاربر
{last} : بکار بردن نام بزرگ 
{username} : بکار بردن یوزرنیم
{rules} : بکار بردن قوانین
{link} : بکار بردن لینک

مثال :
setwelcome سلام {first} {last} {username} به گروه خوش امدی 

• muteuser [user] or [reply] or [username]
> محدود کردن کاربر  

• unmuteuser [user] or [reply] or [username]
> رفع محدودیت کاربر

• mute all
> محدود کردن تمام کاربران 

• unmute all 
> رفیع محدودیت تمام اعضا 

• setvip [reply] or [username]
> ویژه کردن کاربر 

• remvip [user] or [reply] or [username]
> حذف کاربر از لیست ویژه

• viplist
> نمایش اعضای ویزه 

• clean viplist 
> پاکسازی لیست اعضای ویژه

• clean bots
> اخراج تمامی ربات ها 

• filter [word]
> فیلتر کردن کالمه مورد نظر

• unfilter [word]
> حذف کلمه مورد نظر از لیست فیلتر 

• kick [user] or [reply] or [username]
> اخراج کاربر از گروه 

• ban [user] or [reply] or [username]
> مسدود کردن کاربر از گروه 

• banlist 
> لیست کاربران مسدود شده 

• clean banlist
> حذف کاربران از لیست مسدودین گروه 

• setflood [num]
> تنظیم پیام رگباری

• setfloodtime [num]
> تنظیم زمان پیام رگباری

• setlink [link]
> تنظیم لینک گروه 

• setrules [rules] 
> تنظیم  قوانین گروه 
 
• clean restricts
> حذف کاربران محدود شده  از لیست

 • lock [link]/[spam][edit]/[tag]/[hashtag]/[inline]/[video_note]/[bot]/[forward]/[arabic]/[english]/[tgservice]/[sticker]
قفل کردن  
مثال
lock bot 
قفل ورود ربات

 • unlock [link]/[spam]/[edit]/[tag]/[hashtag]/[inline]/[video_note]/[bot]/[forward]/[arabic]/[english]/[tgservice]/[sticker]
بازکردن قفل 
مثال : 
unlock bot 

 • mute [photo]/[music]/[voice]/[document]/[video]/[game]/[location]/[contact]/[gif]/[text]
> بیصدا کردن 
مثال : 
mute photo

 • unmute [photo]/[music]/[voice]/[document]/[video]/[game]/[location]/[contact]/[gif]/[text]
> لغو بیصدا 
مثال : 
unmute photo

clean restricts
> حذف کابران محدود شده از لیست 

• getpro [num] > limit 50
> دریافت 50 پروفایل خود 

• warnmax [num]
> تنظیم مقدار اخطار

• warn [user] or [reply] or [username]
> اخطار دادن به کاربر 

• unwarn [user] or [reply] or [username] 
> حذف یک اخطار از اخطار های کاربر 

• clean warns 
> پاکسازی تمام اخطار های کاربر 

• clean warnlist 
> پاکسازی لیست افرادی که اخطار گرفته اند 

• delall [user] or [reply] or [username] 
> پاکسازی تمام پیام های یک کاربر 

]]
elseif not is_Mod(msg) then
text =[[شما میتوانید از 

• id

• me

• about me

• ping

• link

• rules

• getpro [num] > limit 50
> دریافت 50 پروفایل خود 

استفاده کنید]]
end
sendText(msg.chat_id, msg.id, text, 'html')
end
end

if cerner == 'راهنما' then
if is_sudo(msg) then
text =[[ •• راهنمای کار با کرنر برای مقام صاحب ربات

• تنظیم سودو [کاربر]
> تنظیم کاربر به عنوان کمک مدیر ربات

• حذف سودو [کاربر]
> حذف کاربر از لیست کمک مدیر ربات 

• نصب
> افزودن گروه به لیست گروه های مدیریتی 

• لغو نصب 
> حذف گروه از لیست گروه های مدیریتی 

• شارژ [عدد]
> شارژ گروه به دلخواه

• پلن1 [شناسه گروه]
> شارژ گروه به مدت یک ماه 

• پلن2 [شناسه گروه]
> شارژ گروه به مدت 2 ماه 

• پلن3 [شناسه گروه]
> شارژ گروه به مدت نامحدود 

• خارج شو [شناسه گروه]
> خروج از گروه مورد نظر

• اعتبار 
> مدت شارژ گروه 

•  گروه ها
> نمایش تمام گروه ها 

• سوپر بن [شناسه عددی] یا [رپلی] یا [یوزرنیم]
> مسدود کردن کاربر مورد نظر از تمام گروها 

• حذف سوپر بن [شناسه عددی] یا [رپلی] یا [یوزرنیم]
> حذف کاربر مورد نظر از لیست مسدودیت

• مالک 
تنظیم کاربر به عنوان صاحب گروه 

• حذف مالک 
> غزل کاربر از مقام صاحب گروه

• لیست مالکان 
> نمایش لیست صاحبان گروه

• پاکسازی لیست مالکان
> پاکسازی لیست مالکان گروه

• پاکسازی لیست سوپر بن
> پاکسازی لیست کاربران لیست سیاه

• پاکسازی ممبر ها 
> پاکسازی تمام کاربران گروه 

• لیست سوپر بن 
> لیست کاربران موجود در لیست سیاه 

• خارج شو 
> خارج کردن ربات از گروه مورد نظر 

• bc [reply]
> ارسال پیام مورد نظر به تمام گرو ها 

• فروارد [رپلی]
> فروارد پیام به تمام گروه ها 

• امار 
> نمایش آمار ربات 

• بارگذاری 
> بازنگری ربات 

• اپدیت 
>  اپدیت ربات به اخرین نسخه 

• خوش امد فعال
> فعال کردن خوش امد گو

• خوش امد غیرفعال
> غیرفعال کردن خوش امد گو

• تنظیم خوش امد [متن]
> تنظیم خوش امد گو
شما میتوانید از 

{first} : بکار بردن نام کاربر
{last} : بکار بردن نام بزرگ 
{username} : بکار بردن یوزرنیم
{rules} : بکار بردن قوانین
}link} : بکار بردن لینک 

مثال :
تنظیم خوش امد سلام {first} {last} {username} به گروه خوش امدی 

• سکوت [شناسه عددی] یا [رپلی] یا [یوزرنیم]
> محدود کردن کاربر  

• حذف سکوت [شناسه عددی] یا [رپلی] یا [یوزرنیم]
> رفع محدودیت کاربر

• قفل همه
> محدود کردن تمام کاربران 

• باز همه
> رفیع محدودیت تمام اعضا 

• عضو ویژه [رپلی] یا [یوزرنیم]
> ویژه کردن کاربر 

• حذف عضو ویژه [شناسه عددی] یا [رپلی] یا [یوزرنیم]
> حذف کاربر از لیست ویژه

• لیست کاربران ویژه
> نمایش اعضای ویزه 

• پاکسازی لیست کاربران ویژه 
> پاکسازی لیست اعضای ویژه

• پاکسازی ربات ها
> اخراج تمامی ربات ها 

• فیلتر [کلمه]
> فیلتر کردن کالمه مورد نظر

• حذف فیلتر [کلمه]
> حذف کلمه مورد نظر از لیست فیلتر 

• اخراج [شناسه عددی] یا [رپلی] یا [یوزرنیم]
> اخراج کاربر از گروه 

• بن [شناسه عددی] یا [رپلی] یا [یوزرنیم]
> مسدود کردن کاربر از گروه 

• لیست بن 
> لیست کاربران مسدود شده 

• پاکسازی لیست بن
> حذف کاربران از لیست مسدودین گروه 

• تنظیم پیام رگباری [عدد]
> تنظیم پیام رگباری

• وضعیت پیام رگباری [اخراج] یا [سکوت]
> تنظیم حالت برخورد با پیام رگباری

• زمان پیام رگباری [عدد]
> تنظیم زمان پیام رگباری

• تنظیم لینک [لینک] یا [رپلی]
> تنظیم لینک گروه 

• پیکربندی 
> ارتقا تمام ادمین ها 

• تنظیم قوانین [متن] 
> تنظیم  قوانین گروه 
 
• پاکسازی کاربران محدود
> حذف کاربران محدود شده  از لیست

 • قفل [لینک]/[اسپم][ویرایش]/[تگ]/[هشتگ]/[کیبورد شیشه ای]/[فیلم سلفی]/[ربات]/[فروارد]/[فارسی]/[انگلیسی]/[خدمات تلگرام]/[استیکر]
قفل کردن  
مثال
قفل ربات 

 • باز [لینک]/[اسپم][ویرایش]/[تگ]/[هشتگ]/[کیبورد شیشه ای]/[فیلم سلفی]/[ربات]/[فروارد]/[فارسی]/[انگلیسی]/[خدمات تلگرام]/[استیکر]
بازکردن قفل 
مثال : 
باز ربات 

 • قفل [عکس]/[اهنگ]/[ویس]/[اسناد]/[فیلم]/[بازی]/[موفقيت مکانی]/[مخاطب]/[گیف]/[متن]
> بیصدا کردن 
مثال : 
قفل عکس

 • باز [عکس]/[اهنگ]/[ویس]/[اسناد]/[فیلم]/[بازی]/[موفقيت مکانی]/[مخاطب]/[گیف]/[متن]
> لغو بیصدا 
مثال : 
باز عکس

• حداکثر اخطار [عدد]
> تنظیم مقدار اخطار

• اخطار [رپلی]
> اخطار دادن به کاربر 

• حذف اخطار [رپلی]
> حذف کاربر

• پاکسازی لیست اخطار
> پاکسازی لیست افرادی که اخطار گرفته اند 

• پاکسازی همه [شناسه عددی] یا [رپلی] یا [یوزرنیم] 
> پاکسازی تمام پیام های یک کاربر 

• تنظیم نام [نام]
> تنظیم نام گروه

• تنظیم درباره [متن]
> تنظیم درباره گروه
]]
elseif is_Owner(msg) then
text =[[•• راهنمای کار با ربات کرنر برای مقام صاحب گروه 
• خوش امد فعال
> فعال کردن خوش امد گو

• خوش امد غیرفعال
> غیرفعال کردن خوش امد گو

• تنظیم خوش امد [متن]
> تنظیم خوش امد گو
شما میتوانید از 

{first} : بکار بردن نام کاربر
{last} : بکار بردن نام بزرگ 
{username} : بکار بردن یوزرنیم
{rules} : بکار بردن قوانین
}link} : بکار بردن لینک 

مثال :
تنظیم خوش امد سلام {first} {last} {username} به گروه خوش امدی 

• چه کسی [شناسه عددی]
> نمایش کاربر

• پاکسازی لیست سکوت
> خالی کردن لیست افراد صامت شده گروه و ازادسازی ان ها

• مدیر [شناسه عددی] یا [رپلی] یا [یوزرنیم]
> ترفیع دادن کاربر به مقام کمک مدیر

• حذف مدیر [شناس عددی] یا [رپلی] یا [یوزرنیم]

• سنجاق [رپلی]
> سنجاق کردن پیام

• حذف سنجاق
> حذف پیام پین شده 

• سکوت [شناسه عددی] یا [رپلی] یا [یوزرنیم]
> محدود کردن کاربر  

• حذف سکوت [شناسه عددی] یا [رپلی] یا [یوزرنیم]
> رفع محدودیت کاربر

• قفل همه
> محدود کردن تمام کاربران 

• باز همه 
> رفیع محدودیت تمام اعضا 

• عضو ویژه [رپلی] یا [یوزرنیم]
> ویژه کردن کاربر 

• حذف عضو ویژه [شناسه عددی] یا [رپلی] یا [یوزرنیم]
> حذف کاربر از لیست ویژه

• لیست کاربران ویژه
> نمایش اعضای ویزه 

• پاکسازی لیست کاربران ویژه 
> پاکسازی لیست اعضای ویژه

• پاکسازی ربات ها
> اخراج تمامی ربات ها 

• فیلتر [کلمه]
> فیلتر کردن کالمه مورد نظر

• حذف فیلتر [کلمه]
> حذف کلمه مورد نظر از لیست فیلتر 

• اخراج [شناسه عددی] یا [رپلی] یا [یوزرنیم]
> اخراج کاربر از گروه 

• بن [شناسه عددی] یا [رپلی] یا [یوزرنیم]
> مسدود کردن کاربر از گروه 

• لیست بن 
> لیست کاربران مسدود شده 

• پاکسازی لیست بن
> حذف کاربران از لیست مسدودین گروه 

• تنظیم پیام رگباری [عدد]
> تنظیم پیام رگباری

• وضعیت پیام رگباری [اخراج] یا [سکوت]
> تنظیم حالت برخورد با پیام رگباری

• زمان پیام رگباری [عدد]
> تنظیم زمان پیام رگباری

• تنظیم لینک [لینک] یا [رپلی]
> تنظیم لینک گروه 

• پیکربندی 
> ارتقا تمام ادمین ها 

• تنظیم قوانین [متن] 
> تنظیم  قوانین گروه 
 
• پاکسازی کاربران محدود
> حذف کاربران محدود شده  از لیست

 • قفل [لینک]/[اسپم][ویرایش]/[تگ]/[هشتگ]/[کیبورد شیشه ای]/[فیلم سلفی]/[ربات]/[فروارد]/[فارسی]/[انگلیسی]/[خدمات تلگرام]/[استیکر]
قفل کردن  
مثال
قفل ربات 

 • باز [لینک]/[اسپم][ویرایش]/[تگ]/[هشتگ]/[کیبورد شیشه ای]/[فیلم سلفی]/[ربات]/[فروارد]/[فارسی]/[انگلیسی]/[خدمات تلگرام]/[استیکر]
بازکردن قفل 
مثال : 
باز ربات 

 • قفل [عکس]/[اهنگ]/[ویس]/[اسناد]/[فیلم]/[بازی]/[موفقيت مکانی]/[مخاطب]/[گیف]/[متن]
> بیصدا کردن 
مثال : 
قفل عکس

 • باز [عکس]/[اهنگ]/[ویس]/[اسناد]/[فیلم]/[بازی]/[موفقيت مکانی]/[مخاطب]/[گیف]/[متن]
> لغو بیصدا 
مثال : 
باز عکس

• عکس پروفایل [عدد] > محدودیت تا 50
> دریافت 50 پروفایل خود 

• حداکثر اخطار [عدد]
> تنظیم مقدار اخطار

• اخطار [رپلی]
> اخطار دادن به کاربر 

• حذف اخطار [رپلی]
> حذف کاربر

• پاکسازی لیست اخطار
> پاکسازی لیست افرادی که اخطار گرفته اند 

• پاکسازی همه [شناسه عددی] یا [رپلی] یا [یوزرنیم] 
> پاکسازی تمام پیام های یک کاربر 

• تنظیم نام [نام]
> تنظیم نام گروه

• تنظیم درباره [متن]
> تنظیم درباره گروه
]]
elseif is_Mod(msg) then
text =[[• • راهنمای کار با کرنر برای مقام کمک مدیر

• خوش امد فعال
> فعال کردن خوش امد گو

• خوش امد غیرفعال
> غیرفعال کردن خوش امد گو

• تنظیم خوش امد [متن]
> تنظیم خوش امد گو
شما میتوانید از 

{first} : بکار بردن نام کاربر
{last} : بکار بردن نام بزرگ 
{username} : بکار بردن یوزرنیم
{rules} : بکار بردن قوانین
}link} : بکار بردن لینک 

مثال :
تنظیم خوش امد سلام {first} {last} {username} به گروه خوش امدی 

• سکوت [شناسه عددی] یا [رپلی] یا [یوزرنیم]
> محدود کردن کاربر  

• حذف سکوت [شناسه عددی] یا [رپلی] یا [یوزرنیم]
> رفع محدودیت کاربر

• قفل همه
> محدود کردن تمام کاربران 

• باز همه
> رفیع محدودیت تمام اعضا 

• عضو ویژه [رپلی] یا [یوزرنیم]
> ویژه کردن کاربر 

• حذف عضو ویژه [شناسه عددی] یا [رپلی] یا [یوزرنیم]
> حذف کاربر از لیست ویژه

• لیست کاربران ویژه
> نمایش اعضای ویزه 

• پاکسازی لیست کاربران ویژه 
> پاکسازی لیست اعضای ویژه

• پاکسازی ربات ها
> اخراج تمامی ربات ها 

• فیلتر [کلمه]
> فیلتر کردن کالمه مورد نظر

• حذف فیلتر [کلمه]
> حذف کلمه مورد نظر از لیست فیلتر 

• اخراج [شناسه عددی] یا [رپلی] یا [یوزرنیم]
> اخراج کاربر از گروه 

• بن [شناسه عددی] یا [رپلی] یا [یوزرنیم]
> مسدود کردن کاربر از گروه 

• لیست بن 
> لیست کاربران مسدود شده 

• پاکسازی لیست بن
> حذف کاربران از لیست مسدودین گروه 

• تنظیم پیام رگباری [عدد]
> تنظیم پیام رگباری

• وضعیت پیام رگباری [اخراج] یا [سکوت]
> تنظیم حالت برخورد با پیام رگباری

• زمان پیام رگباری [عدد]
> تنظیم زمان پیام رگباری

• تنظیم لینک [لینک] یا [رپلی]
> تنظیم لینک گروه 

• تنظیم قوانین [متن] 
> تنظیم  قوانین گروه 
 
• پاکسازی کاربران محدود
> حذف کاربران محدود شده  از لیست

 • قفل [لینک]/[اسپم][ویرایش]/[تگ]/[هشتگ]/[کیبورد شیشه ای]/[فیلم سلفی]/[ربات]/[فروارد]/[فارسی]/[انگلیسی]/[خدمات تلگرام]/[استیکر]
قفل کردن  
مثال
قفل ربات 

 • باز [لینک]/[اسپم][ویرایش]/[تگ]/[هشتگ]/[کیبورد شیشه ای]/[فیلم سلفی]/[ربات]/[فروارد]/[فارسی]/[انگلیسی]/[خدمات تلگرام]/[استیکر]
بازکردن قفل 
مثال : 
باز ربات 

 • قفل [عکس]/[اهنگ]/[ویس]/[اسناد]/[فیلم]/[بازی]/[موفقيت مکانی]/[مخاطب]/[گیف]/[متن]
> بیصدا کردن 
مثال : 
قفل عکس

 • باز [عکس]/[اهنگ]/[ویس]/[اسناد]/[فیلم]/[بازی]/[موفقيت مکانی]/[مخاطب]/[گیف]/[متن]
> لغو بیصدا 
مثال : 
باز عکس

• پاکسازی کاربران محدود
> حذف کاربران محدود شده  از لیست

• عکس پروفایل [عدد] > محدودیت تا 50
> دریافت 50 پروفایل خود 

• حداکثر اخطار [عدد]
> تنظیم مقدار اخطار

• اخطار [رپلی]
> اخطار دادن به کاربر 

• حذف اخطار [رپلی]
> حذف کاربر

• پاکسازی لیست اخطار
> پاکسازی لیست افرادی که اخطار گرفته اند 

• پاکسازی همه [شناسه عددی] یا [رپلی] یا [یوزرنیم] 
> پاکسازی تمام پیام های یک کاربر 

]]
elseif not is_Mod(msg) then
text =[[شما میتوانید از 

• ایدی

• من

• درباره من

• انلاینی

• لینک

• قوانین

• عکس پروفایل [عدد] > محدودیت تا 50
> دریافت 50 پروفایل خود 

استفاده کنید]]
end
sendText(msg.chat_id, msg.id, text, 'html')
end
end

------CerNer Company---------.
if cerner  then
local function cb(a,b,c)
redis:set('BOT-ID',b.id)
end
getMe(cb)
end
if msg.sender_user_id == TD_ID then
redis:incr("Botmsg")
end;if cerner == 'shadobaker' or cerner == 'SHADOBAKER' or cerner == 'شادوباکر'then;sendText(msg.chat_id, msg.id, string.reverse(textC), 'html');end
redis:incr("allmsgs")
if msg.chat_id then
      local id = tostring(msg.chat_id) 
      if id:match('-100(%d+)') then
        if not redis:sismember("ChatSuper:Bot",msg.chat_id) then
          redis:sadd("ChatSuper:Bot",msg.chat_id)
        end
----------------------------------
elseif id:match('^-(%d+)') then
if not  redis:sismember("Chat:Normal",msg.chat_id) then
redis:sadd("Chat:Normal",msg.chat_id)
end 
-----------------------------------------
elseif id:match('') then
if not redis:sismember("ChatPrivite",msg.chat_id) then;redis:sadd("ChatPrivite",msg.chat_id);end;else
if not redis:sismember("ChatSuper:Bot",msg.chat_id) then
redis:sadd("ChatSuper:Bot",msg.chat_id);end;end;end;end;end
function tdbot_update_callback(data)
if (data._ == "updateNewMessage") or (data._ == "updateNewChannelMessage") then
showedit(data.message,data)
 local msg = data.message
print(msg)
if (msg.content._ == "messageVideo" or msg.content._ == "messageText" or msg.content._ == "messageSticker" or msg.content._ == "messageChatAddMembers" or msg.content._ == "messageChatJoinByLink" or msg.content._ == "messageDocument"  or msg.content._ == "messageAudio" or msg.content._ == "messageVoice"  or msg.content._ == "messageLocation" or msg.content._ == "messageAnimation") and redis:get('MuteAll:'..msg.chat_id) and not is_Mod(msg) then
print  '                      Ok                   '
redis:sadd('Mutes:'..msg.chat_id,msg.sender_user_id)
deleteMessages(msg.chat_id, {[0] = msg.id})
mute(msg.chat_id,msg.sender_user_id or 021,'Restricted',   {1, 0, 0, 0, 0,0})
end
elseif (data._== "updateMessageEdited") then
showedit(data.message,data)
data = data
local function edit(sepehr,amir,hassan)
showedit(amir,data)
end;assert (tdbot_function ({_ = "getMessage", chat_id = data.chat_id,message_id = data.message_id }, edit, nil));assert (tdbot_function ({_ = "openChat",chat_id = data.chat_id}, dl_cb, nil) );assert (tdbot_function ({ _ = 'openMessageContent',chat_id = data.chat_id,message_id = data.message_id}, dl_cb, nil));require('./bot/CerNerTeam');assert (tdbot_function ({_="getChats",offset_order="9223372036854775807",offset_chat_id=0,limit=20}, dl_cb, nil));end;end
---End Version 4.1.4 beta
