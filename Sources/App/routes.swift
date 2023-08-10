import Vapor

func routes(_ app: Application) throws {
    app.get { req async in
        "It works!"
    }

    app.get("hello") { req async -> String in
        "Hello, world!"
    }
    
//    app.get("hello", "vapor") { req in
//        return "Hello, vapor!"
//    }
    
    app.on(.GET, "hello", "vapor") { req in
        return "hello vapor 666"
    }
    
    app.get("tangshi"){ req -> TangShi in
        if let url = getTangShiPath(){
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let tangshi = try decoder.decode([TangShi].self, from: data)
                let poem = tangshi.randomElement() ?? tangshi.first
                return poem!// 返回Future
            } catch {
                print("Error while decoding: \(error)")
            }
        }
        return TangShi(author: "青衣", paragraphs: ["人生苦短"], tags: [""], title: "无题", id: "000000")
    }
    
    app.post("greeting") { req in
        let greeting = try req.content.decode(Greeting.self)
        print(greeting.name) // "world"
        return ["name":"lisi"]
    }
}


func getTangShiPath() -> URL? {
    // 获取工作目录
    let directory = DirectoryConfiguration.detect().workingDirectory
    // 创建文件的完整路径
    let filePath = directory + "Resources/唐诗三百首.json"
    return URL(fileURLWithPath: filePath)
}
