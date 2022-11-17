import com.tbruyelle.rxpermissions3.RxPermissions

fun RxPermissions.allIsGranted(pes: MutableList<String>): Boolean {
    pes.map {
        if (!this.isGranted(it)) {
            return false
        }
    }
    return true
}