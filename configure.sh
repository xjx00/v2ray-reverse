#!/bin/sh

# Download and install V2Ray
mkdir /tmp/v2ray
wget -q https://github.com/v2fly/v2ray-core/releases/latest/download/v2ray-linux-64.zip -O /tmp/v2ray/v2ray.zip
unzip /tmp/v2ray/v2ray.zip -d /tmp/v2ray
install -m 755 /tmp/v2ray/v2ray /usr/local/bin/v2ray
install -m 755 /tmp/v2ray/v2ctl /usr/local/bin/v2ctl

# Remove temporary directory
rm -rf /tmp/v2ray

# V2Ray new configuration
install -d /usr/local/etc/v2ray
cat << EOF > /usr/local/etc/v2ray/config.json
{  
  "reverse":{  
    "portals":[  
      {  
        "tag":"portal",
        "domain":"proxy.v2ray.cn" 
      }
    ]
  },
  "inbounds":[
    {  
      "tag":"tunnel", 
      "port":$PORT,
      "protocol":"vmess",
      "settings":{  
        "clients":[  
          {  
            "id":"$UUID",
            "alterId":64
          }
        ]
      },
      "streamSettings": {
        "network":"ws"
      }
    }
  ],
  "routing":{   
    "rules":[  
      {  //路由规则，接收 C 的请求后发给 A
        "type":"field",
        "inboundTag":[  
          "external"
        ],
        "outboundTag":"portal"
      },
      {  //路由规则，让 B 能够识别这是 A 主动发起的反向代理连接
        "type":"field",
        "inboundTag":[  
          "tunnel"
        ],
        "domain":[  
          "full:proxy.v2ray.cn"
        ],
        "outboundTag":"portal"
      }
    ]
  }
}
EOF

# Run V2Ray
/usr/local/bin/v2ray -config /usr/local/etc/v2ray/config.json
