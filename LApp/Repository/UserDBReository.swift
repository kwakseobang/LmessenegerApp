//
//  UserDBReository.swift
//  LApp
//
//  Created by 곽서방 on 7/22/24.
//

import Foundation
import Combine
import FirebaseDatabase

//firebase DB 연동 담당
//userService를 combine 통해 연결 예정
protocol UserDBReositoryType {
    //user 정보 받아서 DB에 전달
    func addUser(_ object: UserObject) -> AnyPublisher<Void,DBError>
    func getUser(_ userid: String) -> AnyPublisher<UserObject,DBError>
}
class UserDBReository: UserDBReositoryType {
 
    
    //firebase DB에 접근할려면 reference(db에서 Root에 해당) 객체가 필요하다.
    var db: DatabaseReference = Database.database().reference()
    
    func addUser(_ object: UserObject) -> AnyPublisher<Void,DBError> {
        Just(object)          //firebase에 데이터를 보낼려면 딕셔너리 형태여야함. object -> data -> dic
            .compactMap { try? JSONEncoder().encode($0)} //incoding = data 변환
            .compactMap { try? JSONSerialization.jsonObject(with: $0, options: .fragmentsAllowed )} //dic로 변환
            .flatMap { value in   //db에 설정하는 작업 realtime database는 combine 제공 x
                Future<Void, Error> { [weak self] promise in  //Users/userid/ 밑에 데이터 전달하는과정
                    self?.db.child(DBKey.Users).child(object.id).setValue(value) { error, _ in
                        if let error {
                            promise(.failure(error))
                        } else {
                            promise(.success(()))
                        }
                    }
                }
            }
            .mapError{ DBError.error($0) } //error 타입을 DBerror 타입으로 변환
            .eraseToAnyPublisher()
    }
    
    func getUser(_ userid: String) -> AnyPublisher<UserObject, DBError> {
        Future<Any?,DBError  > { [weak self] promise in
            self?.db.child(DBKey.Users).child(userid).getData{ error, snapshot in
                if let error {
                    promise(.failure(DBError.error(error)))
                } else  if snapshot?.value is NSNull {
                    //snapshot은 nil이 아니라 NSNULL을 가지고 있음
                    promise(.success(nil)  )
                } else {
                    promise(.success(snapshot?.value))  //snapshot?.value은 dic 형태이다.
                }
            }
            
        } // snapshot?.value -> data화 -> pasing
        .flatMap { value in
            // snapshot을 userobject로 변환
            if let value {
                return Just(value)
                    .tryMap { try JSONSerialization.data(withJSONObject: $0) } //data
                    .decode(type: UserObject.self, decoder: JSONDecoder())
                    .mapError {DBError.error($0) }
                    .eraseToAnyPublisher()
            } else {
               return Fail(error: .emptyValue).eraseToAnyPublisher()
            }
        }
        .eraseToAnyPublisher()
    }

}
