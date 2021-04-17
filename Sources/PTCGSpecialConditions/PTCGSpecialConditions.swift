/**
 * 状態異常
 */
public enum PTCGSpecialConditions {
    
    enum ConditionLayer {
        /**
         * 「どく」の状態
         */
        case poisoned
        /**
         * 「やけど」の状態
         */
        case burned
        /**
         * カードの向きによって表せる状態 (e.g. 横向き: 「ねむり」・「マヒ」、逆向き:「こんらん」)
         */
        case rotation
    }

    /**
     * 状態異常区分
     */
    var layer: ConditionLayer {
        switch self {
        case .poisoned(_):
            return .poisoned
        case .burned:
            return .burned
        case .asleep, .paralyzed, .confused:
            return .rotation
        }
    }
    
    /**
     * どく
     * ポケモンチェック時、「どく」のポケモンに指定された数のダメカンをのせる
     * 特に「どく」の効果を指定されていない場合は「10」のダメカンを1個のせる
     */
    case poisoned(Int?)
    
    /**
     * やけど
     * ポケモンチェック時、「やけど」のポケモンに「10」のダメカンを2個のせる。
     * その後コインを投げて、オモテならそのポケモンは「やけど」から回復
     */
    case burned
    
    /**
     * ねむり
     * 「ねむり」になったポケモンは、自分の番、ワザと「にげる」が使えなくなる。
     * ポケモンチェック時、「ねむり」のチェックをする。
     * コインを投げてオモテなら「ねむり」から回復。ウラなら「ねむり」はつづく
     */
    case asleep
    
    /**
     * マヒ
     * 「マヒ」になったポケモンは、そのあとの自分の番、ワザと「にげる」が使えなくなる。
     * ポケモンチェック時、「マヒ」で自分の番を1回すごしたポケモンは、「マヒ」から回復
     */
    case paralyzed
    
    /**
     * こんらん
     * 使うワザを決めたら、持ち主はコインを投げます。
     * オモテならそのワザを使えますが、ウラだとワザは失敗して、
     * ワザを使ったポケモン自身にダメカンを30ダメージぶんのせる。
     * 「こんらん」になっても、「にげる」は使える。
     */
    case confused

    var name: String {
        switch self {
        case .poisoned(_):
            return "どく"
        case .burned:
            return "やけど"
        case .asleep:
            return "ねむり"
        case .paralyzed:
            return "マヒ"
        case .confused:
            return "こんらん"
        }
    }

    /**
     * ポケモンチェック時における状態異常処理の優先度
     * いくつかの特殊状態がかさなっているときは、次の順番でチェックする
     * どく -> やけど -> ねむり -> マヒ
     */
    var checkPriority: Int? {
        switch self {
        case .poisoned(_):
            return 4
        case .burned:
            return 3
        case .asleep:
            return 2
        case .paralyzed:
            return 1
        case .confused:
            // NOTE: 「こんらん」はポケモンチェックにおいて確認しないため「nil」とする
            return nil
        }
    }
    
    var canEscaping: Bool {
        switch self {
        case .poisoned(_), .burned, .confused:
            return true
        case .asleep, .paralyzed:
            return false
        }
    }
    
    var canUsingSkill: Bool {
        switch self {
        case .poisoned(_), .burned, .confused:
            return true
        case .asleep, .paralyzed:
            return false
        }
    }
}
