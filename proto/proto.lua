local sprotoparser = require "sprotoparser"

local proto = {}

proto.c2s = sprotoparser.parse [[
.package {
    type 0 : integer
    session 1 : integer
}

quit 1 {}

login 2 {
    request {
        id 0 : string
        password 1 : string
    }
    response {
        errcode 0 : integer
    }
}

quickstart 3 {
    response {
        errcode 0 : integer
        waittime 1 : integer
        seat 2 : integer
    }
}

ready 4 {
    response {
        errcode 0 : integer
    }    
}

cancelready 5 {
    response {
        errcode 0 : integer
    }      
}

cancelstart 6 {
    response {
        errcode 0 : integer
    }
}

calllandholder 7 {
    request {
        call 0 : boolean
    }
    response {
        errcode 0 : integer
    }
}

.card {
    card 0 : *integer
    type 1 : integer
}

followcard 8 {
    request {
        fwcard 0 : *card
        handtype 1 : integer    
    }
    response {
        errcode 0 : integer
    }
}

passfollow 9 {
    response {
        errcode 0 : integer
    }
}

]]

--[[
1-quickstart：快速开始
2-ready：准备
3-cancelready：取消准备
4-cancelstart：取消开始
5-calllandholder：是否叫地主或者抢地主
6-followcard：出牌，handtype-出牌类型
7-passfollow：不跟
]]

proto.s2c = sprotoparser.parse [[
.package {
    type 0 : integer
    session 1 : integer
}

heartbeat 1 {
	request {
		servertimer 0 : integer
	}
}

.card {
	card 0 : *integer
	type 1 : integer
}

handcard 2 {
	request {
		myCard 1 : *card
		otherplayer_1 2 : integer
		otherplayer_2 3 : integer
	}
}

callpriority 3 {
	request {
		priority 0 : integer
		time 1 : integer
	}
}

callholder 4 {
	request {
		result 0 : boolean
		nextcall 1 : integer
	}
}

landholder 5 {
	request {
		dizhu 0 : *card
		landholder 1 : integer
	}
}

followcard 6 {
    request {
        fwcard 0 : *card
        handtype 1 : integer    
        seat 2 : integer
        leftcard 3: integer
    }
}

passfollow 7 {
	request {
		seat 0 : integer
	}
}

handoutpriority 8 {
	request {
		priority 0 : integer
		time 1 : integer
	}
}

gameover 9 {
	request {
		win 0 : integer
	}
}

]]

--[[
1-handcard：发牌
2-callpriority：叫地主或者抢地主权利
3-followcard：出牌，handtype-出牌类型，seat-座位，leftcard-剩余数量
4-passfollow：不跟
]]


return proto