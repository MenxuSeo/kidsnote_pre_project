//
//  kidsnote_pre_projectTests.swift
//  kidsnote_pre_projectTests
//
//  Created by seo on 28/7/24.
//

import XCTest

final class kidsnote_pre_projectTests: XCTestCase {
  
  func testBooksDecodable() {
    //given
    let json = Data("""
{
    "kind": "books#volumes",
    "totalItems": 793,
    "items": [
        {
            "kind": "books#volume",
            "id": "nGh2AgAAQBAJ",
            "etag": "51eHPNI4GPs",
            "selfLink": "https://www.googleapis.com/books/v1/volumes/nGh2AgAAQBAJ",
            "volumeInfo": {
                "title": "건곤쟁패 1권",
                "authors": [
                    "가람검"
                ],
                "publisher": "프로무림",
                "publishedDate": "2013-03-05",
                "description": "국내 최대의 장르사이트 선호작, 골든 베스트 - 게임 부문 1위! 'K.J.C' 세 나라의 스펙터클한 프로젝트가 시작된다. 앞으로 여러분들이 경험하시게 될 건곤쟁패는 또 다른 여러분들의 인생! 바로 제2의 인생이 될 것입니다. 현실에 만족할 수 없다면 건곤쟁패를 통해 자신의 또 다른 인생을 개척해 나가시길 바랍니다. -본문 중 복불복, 모 아니면 도다. 광활한 대륙의 역사 속에 스며들어 나만의 세계를 만든다. 가람검 - [건곤쟁패] 가상현실게임의 절대지존이 시작된다! 띠링! 접속하시겠습니까?",
                "industryIdentifiers": [
                    {
                        "type": "OTHER",
                        "identifier": "PKEY:139750"
                    }
                ],
                "readingModes": {
                    "text": true,
                    "image": true
                },
                "pageCount": 231,
                "printType": "BOOK",
                "categories": [
                    "Fiction"
                ],
                "maturityRating": "NOT_MATURE",
                "allowAnonLogging": true,
                "contentVersion": "1.3.3.0.preview.3",
                "panelizationSummary": {
                    "containsEpubBubbles": false,
                    "containsImageBubbles": false
                },
                "imageLinks": {
                    "smallThumbnail": "http://books.google.com/books/content?id=nGh2AgAAQBAJ&printsec=frontcover&img=1&zoom=5&edge=curl&source=gbs_api",
                    "thumbnail": "http://books.google.com/books/content?id=nGh2AgAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api"
                },
                "language": "ko",
                "previewLink": "http://books.google.co.kr/books?id=nGh2AgAAQBAJ&pg=PT84&dq=1&hl=&cd=1&source=gbs_api",
                "infoLink": "https://play.google.com/store/books/details?id=nGh2AgAAQBAJ&source=gbs_api",
                "canonicalVolumeLink": "https://play.google.com/store/books/details?id=nGh2AgAAQBAJ"
            },
            "saleInfo": {
                "country": "KR",
                "saleability": "FOR_SALE",
                "isEbook": true,
                "listPrice": {
                    "amount": 0,
                    "currencyCode": "KRW"
                },
                "retailPrice": {
                    "amount": 0,
                    "currencyCode": "KRW"
                },
                "buyLink": "https://play.google.com/store/books/details?id=nGh2AgAAQBAJ&rdid=book-nGh2AgAAQBAJ&rdot=1&source=gbs_api"
            },
            "accessInfo": {
                "country": "KR",
                "viewability": "ALL_PAGES",
                "embeddable": true,
                "publicDomain": false,
                "textToSpeechPermission": "ALLOWED",
                "epub": {
                    "isAvailable": true,
                    "acsTokenLink": "http://books.google.co.kr/books/download/%EA%B1%B4%EA%B3%A4%EC%9F%81%ED%8C%A8_1%EA%B6%8C-sample-epub.acsm?id=nGh2AgAAQBAJ&format=epub&output=acs4_fulfillment_token&dl_type=sample&source=gbs_api"
                },
                "pdf": {
                    "isAvailable": true,
                    "acsTokenLink": "http://books.google.co.kr/books/download/%EA%B1%B4%EA%B3%A4%EC%9F%81%ED%8C%A8_1%EA%B6%8C-sample-pdf.acsm?id=nGh2AgAAQBAJ&format=pdf&output=acs4_fulfillment_token&dl_type=sample&source=gbs_api"
                },
                "webReaderLink": "http://play.google.com/books/reader?id=nGh2AgAAQBAJ&hl=&source=gbs_api",
                "accessViewStatus": "SAMPLE",
                "quoteSharingAllowed": false
            },
            "searchInfo": {
                "textSnippet": "... <b>1</b>시간 안으로 천둥봉을 갔다 오지 못하면 네놈의 골통을 바숴 버리겠어! 출발해!” 매번 같은 말을 내뱉는 백문구. 하지만 ... <b>1</b>시간 20 분이었다. 당연히 백문구의 입장에서는 내가 <b>1</b>시간 안으로 천둥 봉을 갔다 오리라곤 믿지 않았다. 나는 백문구&nbsp;..."
            }
        }
        ]
}
""".utf8)
    
    // when
    var bookResponse: BooksResponse?
  
    do {
      bookResponse = try JSONDecoder().decode(BooksResponse.self, from: json)
      print(bookResponse)
    } catch let DecodingError.dataCorrupted(context) {
      XCTFail(context.debugDescription)
    } catch let DecodingError.keyNotFound(key, context) {
      print("Key '\(key)' not found:", context.debugDescription)
      print("codingPath:", context.codingPath)
      XCTFail(context.debugDescription)
    } catch let DecodingError.valueNotFound(value, context) {
      print("Value '\(value)' not found:", context.debugDescription)
      print("codingPath:", context.codingPath)
      XCTFail(context.debugDescription)
    } catch let DecodingError.typeMismatch(type, context)  {
      print("Type '\(type)' mismatch:", context.debugDescription)
      print("codingPath:", context.codingPath)
      XCTFail(context.debugDescription)
    } catch {
      print("error: ", error)
      XCTFail(error.localizedDescription)
    }
    
    // then
    let items = try? XCTUnwrap(bookResponse?.items)
    XCTAssertNotNil(items?.first?.id)
    XCTAssertEqual(items?.first?.title, "건곤쟁패 1권")
  }
  
}
