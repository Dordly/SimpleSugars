//
//  APPURLAPI.swift
//  SimpleSugars
//
//  Created by 苑伟 on 16/8/24.
//  Copyright © 2016年 苑伟. All rights reserved.
//

import UIKit

class APPURLAPI: NSObject {
    
    // 获取首页轮播数据
    class func loadHomeShuffling() -> APPURLParams{
        let action = "/v1/banners"
        let urlFormat = "channel=iOS"
        let url = APPURLParams.urlWithAction(action, params: urlFormat)
        return url
    }

    // 获取首页数据
    class func loadHomeInfo(_ id: String) -> APPURLParams{
        let action = "v1/channels/\(id)/items"
        let urlFormat = "gender=1&generation=1&limit=20&offset=0"
        let url = APPURLParams.urlWithAction(action, params: urlFormat)
        return url
    }
    // 获取首页顶部选择数据
    class func loadHomeTopData() -> APPURLParams{
        let action = "v2/channels/preset"
        let urlFormat = "gender=1&generation=1"
        let url = APPURLParams.urlWithAction(action, params: urlFormat)
        return url
    }
    // 获取首页进入详情数据
    class func loadHomeDetailData(id: String) -> APPURLParams{
        let action = "v1/posts/\(id)"
        let urlFormat = ""
        let url = APPURLParams.urlWithAction(action, params: urlFormat)
        return url
    }
    // 搜索界面数据
    class func loadHotWords() -> APPURLParams{
        let action = "v1/search/hot_words"
        let urlFormat = ""
        let url = APPURLParams.urlWithAction(action, params: urlFormat)
        return url
    }
    // 根据搜索条件进行搜索
    class func loadSearchResult(_ keyword: String, sort: String) -> APPURLParams{
        let action = "v1/search/item"
        let urlFormat = "keyword=\((keyword))&sort=\((sort))&limit=20&offset=0"
        let url = APPURLParams.urlWithAction(action, params: urlFormat)
        return url

    }
    // 获取单品数据
    class func loadProductData() -> APPURLParams{
        let action = "v2/items"
        let urlFormat = "gender=1&generation=1&limit=20&offset=0"
        let url = APPURLParams.urlWithAction(action, params: urlFormat)
        return url
    }
    
    // 获取单品详情数据
    class func loadProductDetailData(_ id: String) -> APPURLParams{
        let action = "v2/items/\(id)"
        let urlFormat = ""
        let url = APPURLParams.urlWithAction(action, params: urlFormat)
        return url
    }

    // 商品详情 评论
    class func loadProductDetailComments(_ id: String) -> APPURLParams{
        let action = "v2/items/\(id)/comments"
        let urlFormat = "limit=20&offset=0"
        let url = APPURLParams.urlWithAction(action, params: urlFormat)
        return url
    }
    // 全部专题合集
    class func loadCategoryCollection(_ limit: String) -> APPURLParams{
        let action = "v1/collections"
        let urlFormat = "limit=\((limit))&offset=0"
        let url = APPURLParams.urlWithAction(action, params: urlFormat)
        return url
    }
    // 顶部 专题合集 -> 专题列表
    class func loadCollectionPosts(_ id: String) -> APPURLParams{
        let action = "v1/collections/\(id)/posts"
        let urlFormat = "gender=1&generation=1&limit=20&offset=0"
        let url = APPURLParams.urlWithAction(action, params: urlFormat)
        return url
    }
    // 分类界面 风格,品类
    class func loadCategoryGroup() -> APPURLParams{
        let action = "v1/channel_groups/all"
        let urlFormat = ""
        let url = APPURLParams.urlWithAction(action, params: urlFormat)
        return url
    }
    // 底部 风格品类 -> 列表
    class func loadStylesOrCategoryInfo(_ id: String) -> APPURLParams{
        let action = "v1/channels/\(id)/items"
        let urlFormat = "limit=20&offset=0"
        let url = APPURLParams.urlWithAction(action, params: urlFormat)
        return url
    }
}
