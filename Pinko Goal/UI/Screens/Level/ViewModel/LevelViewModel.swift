import Foundation
import Combine

class LevelViewModel: ObservableObject {
    @Published private(set) var openedLevels: [Int] = []
    
    private let userDefaults = UserDefaults.standard
    private let openedLevelsKey = "openedLevels"

    init() {
        self.openedLevels = getOpenedLevels()
        if !isLevelOpened(levels[0]) {
            openLevel(1)
        }
    }

    // Метод для открытия нового уровня
    func openLevel(_ levelId: Int) {
        let level = levels[levelId - 1]
        if !openedLevels.contains(level.id) {
            openedLevels.append(level.id)
            saveOpenedLevels(openedLevels)
        }
    }

    // Метод для проверки, открыт ли уровень
    func isLevelOpened(_ level: Level) -> Bool {
        return openedLevels.contains(level.id)
    }

    // Метод для сохранения открытых уровней в UserDefaults
    private func saveOpenedLevels(_ levels: [Int]) {
        userDefaults.set(levels, forKey: openedLevelsKey)
    }

    // Метод для загрузки открытых уровней из UserDefaults
    private func getOpenedLevels() -> [Int] {
        return userDefaults.array(forKey: openedLevelsKey) as? [Int] ?? []
    }
}
