import ProjectDescription

let project = Project(
    name: "kidsnote_pre_project",
    targets: [
        .target(
            name: "kidsnote_pre_project",
            destinations: .iOS,
            product: .app,
            bundleId: "io.tuist.kidsnote-pre-project",
            infoPlist: .extendingDefault(
                with: [
                    "UILaunchScreen": [
                        "UIColorName": "",
                        "UIImageName": "",
                    ],
                ]
            ),
            sources: ["kidsnote_pre_project/Sources/**"],
            resources: ["kidsnote_pre_project/Resources/**"],
            dependencies: []
        ),
        .target(
            name: "kidsnote_pre_projectTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "io.tuist.kidsnote-pre-projectTests",
            infoPlist: .default,
            sources: ["kidsnote_pre_project/Tests/**"],
            resources: [],
            dependencies: [.target(name: "kidsnote_pre_project")]
        ),
    ]
)
