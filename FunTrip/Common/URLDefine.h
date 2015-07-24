//
//  URLDefine.h
//  Travel
//
//  Created by Chinsyo on 15/6/3.
//  Copyright (c) 2015年 Chinsyo. All rights reserved.
//

#ifndef Travel_URLDefine_h
#define Travel_URLDefine_h
//&track_app_version=6.3
//推荐页面接口
#define REC_URL @"http://open.qyer.com/qyer/recommands/entry?client_id=qyer_android&client_secret=9fcaae8aefc4f9ac4915&v=1&track_app_version=6.3&track_user_id=&track_device_info=dior&oauth_token="

//推荐页面cell加载
#define REC_CELL_URL @"http://open.qyer.com/qyer/recommands/trip?client_id=qyer_android&client_secret=9fcaae8aefc4f9ac4915&track_app_version=6.3&type=index&page=%ld&count=10"

//目的地页面接口
#define DES_URL @"http://open.qyer.com/qyer/footprint/continent_list?client_id=qyer_android&client_secret=9fcaae8aefc4f9ac4915&v=1track_app_version=6.3&track_user_id=&track_device_info=dior"

//社区页面接口
#define GROUO_URL @"http://open.qyer.com/qyer/bbs/forum_list?client_id=qyer_android&client_secret=9fcaae8aefc4f9ac4915&v=1&track_app_version=6.3&track_user_id=&lat=34.786472&lon=113.671383"


//点击社区页面进入Post&page=%ld  &type=%@(&forum_type=6)  &forum_id=%@
#define GROUP_DETAIL_URL_POST @"http://open.qyer.com/qyer/bbs/forum_thread_list?client_id=qyer_android&client_secret=9fcaae8aefc4f9ac4915&v=1&track_app_version=6.3&track_user_id=&lat=34.786486&lon=113.6714&count=10&delcache=0"

//点推荐页面当地特色进入
#define LOCATION_URL @"http://open.qyer.com/qyer/footprint/mguide_detail?client_id=qyer_android&client_secret=9fcaae8aefc4f9ac4915&v=1track_app_version=6.3&track_user_id=&lat=34.786486&lon=113.6714&oauth_token=&id=%@&page=1&count=10"  //model.id

//点推荐页面特价折扣进入
#define DISCOUNT_URL   @"http://m.qyer.com/z/deal/%@/source=app" //model.id

//点击目的地界面具体国家进入
#define DES_DETAIL_COUNTRY_URL   @"http://open.qyer.com/qyer/footprint/country_detail?client_id=qyer_android&client_secret=9fcaae8aefc4f9ac4915&v=1&track_app_version=6.3&country_id=%@&oauth_token="  //model.id
//点击目的地界面国家具体城市进入
#define DES_DETAIL_CITY_URL  @"http://open.qyer.com/qyer/footprint/city_detail?client_id=qyer_android&client_secret=9fcaae8aefc4f9ac4915&v=1&track_app_version=6.3&track_app_channel=qq&track_device_info=dior&city_id=%@&oauth_token="

//点击具体城市页面圆形button   
#define DES_DETAIL_CITY_CORCLE_BUTTON_URL @"http://open.qyer.com/qyer/onroad/poi_list?client_id=qyer_android&client_secret=9fcaae8aefc4f9ac4915&v=1&track_app_version=6.3&page=1&city_id=%@&category_id=%@&count=20&types=&orderby=popular&oauth_token="

//点击具体城市页面圆形button进入后点击地图
#define  MAP_URL   @"http://open.qyer.com/qyer/map/%@_list?client_id=qyer_android&client_secret=9fcaae8aefc4f9ac4915&v=1&track_app_version=6.3&lat=34.786481&lon=113.671396"

//热门城市点击查看全部
#define  ALL_HOT_CITY_URL   @"http://open.qyer.com/place/city/get_city_list?client_id=qyer_android&client_secret=9fcaae8aefc4f9ac4915&v=1&track_app_version=6.3&countryid=%@&page=%@"

#endif

