require 'ffi'

module FFI
  module VixDiskLib
    module API
      extend FFI::Library

      def self.enum(*args)
        s = super
        # Expose enums as constants
        s.symbols.each { |sym| const_set(sym, s[sym]) }
        s
      end

      # The error codes are returned by all public VIX routines.
      VixErrorType = enum(
        :VIX_OK, 0,

        # General errors
        :VIX_E_FAIL, 1,
        :VIX_E_OUT_OF_MEMORY, 2,
        :VIX_E_INVALID_ARG, 3,
        :VIX_E_FILE_NOT_FOUND, 4,
        :VIX_E_OBJECT_IS_BUSY, 5,
        :VIX_E_NOT_SUPPORTED, 6,
        :VIX_E_FILE_ERROR, 7,
        :VIX_E_DISK_FULL, 8,
        :VIX_E_INCORRECT_FILE_TYPE, 9,
        :VIX_E_CANCELLED, 10,
        :VIX_E_FILE_READ_ONLY, 11,
        :VIX_E_FILE_ALREADY_EXISTS, 12,
        :VIX_E_FILE_ACCESS_ERROR, 13,
        :VIX_E_REQUIRES_LARGE_FILES, 14,
        :VIX_E_FILE_ALREADY_LOCKED, 15,
        :VIX_E_VMDB, 16,
        :VIX_E_NOT_SUPPORTED_ON_REMOTE_OBJECT, 20,
        :VIX_E_FILE_TOO_BIG, 21,
        :VIX_E_FILE_NAME_INVALID, 22,
        :VIX_E_ALREADY_EXISTS, 23,
        :VIX_E_BUFFER_TOOSMALL, 24,
        :VIX_E_OBJECT_NOT_FOUND, 25,
        :VIX_E_HOST_NOT_CONNECTED, 26,
        :VIX_E_INVALID_UTF8_STRING, 27,
        :VIX_E_OPERATION_ALREADY_IN_PROGRESS, 31,
        :VIX_E_UNFINISHED_JOB, 29,
        :VIX_E_NEED_KEY, 30,
        :VIX_E_LICENSE, 32,
        :VIX_E_VM_HOST_DISCONNECTED, 34,
        :VIX_E_AUTHENTICATION_FAIL, 35,
        :VIX_E_HOST_CONNECTION_LOST, 36,
        :VIX_E_DUPLICATE_NAME, 41,

        # Handle Errors
        :VIX_E_INVALID_HANDLE, 1000,
        :VIX_E_NOT_SUPPORTED_ON_HANDLE_TYPE, 1001,
        :VIX_E_TOO_MANY_HANDLES, 1002,

        # XML errors
        :VIX_E_NOT_FOUND, 2000,
        :VIX_E_TYPE_MISMATCH, 2001,
        :VIX_E_INVALID_XML, 2002,

        # VM Control Errors
        :VIX_E_TIMEOUT_WAITING_FOR_TOOLS, 3000,
        :VIX_E_UNRECOGNIZED_COMMAND, 3001,
        :VIX_E_OP_NOT_SUPPORTED_ON_GUEST, 3003,
        :VIX_E_PROGRAM_NOT_STARTED, 3004,
        :VIX_E_CANNOT_START_READ_ONLY_VM, 3005,
        :VIX_E_VM_NOT_RUNNING, 3006,
        :VIX_E_VM_IS_RUNNING, 3007,
        :VIX_E_CANNOT_CONNECT_TO_VM, 3008,
        :VIX_E_POWEROP_SCRIPTS_NOT_AVAILABLE, 3009,
        :VIX_E_NO_GUEST_OS_INSTALLED, 3010,
        :VIX_E_VM_INSUFFICIENT_HOST_MEMORY, 3011,
        :VIX_E_SUSPEND_ERROR, 3012,
        :VIX_E_VM_NOT_ENOUGH_CPUS, 3013,
        :VIX_E_HOST_USER_PERMISSIONS, 3014,
        :VIX_E_GUEST_USER_PERMISSIONS, 3015,
        :VIX_E_TOOLS_NOT_RUNNING, 3016,
        :VIX_E_GUEST_OPERATIONS_PROHIBITED, 3017,
        :VIX_E_ANON_GUEST_OPERATIONS_PROHIBITED, 3018,
        :VIX_E_ROOT_GUEST_OPERATIONS_PROHIBITED, 3019,
        :VIX_E_MISSING_ANON_GUEST_ACCOUNT, 3023,
        :VIX_E_CANNOT_AUTHENTICATE_WITH_GUEST, 3024,
        :VIX_E_UNRECOGNIZED_COMMAND_IN_GUEST, 3025,
        :VIX_E_CONSOLE_GUEST_OPERATIONS_PROHIBITED, 3026,
        :VIX_E_MUST_BE_CONSOLE_USER, 3027,
        :VIX_E_VMX_MSG_DIALOG_AND_NO_UI, 3028,
        # VIX_E_NOT_ALLOWED_DURING_VM_RECORDING, 3029, Removed in version 1.11
        # VIX_E_NOT_ALLOWED_DURING_VM_REPLAY, 3030, Removed in version 1.11
        :VIX_E_OPERATION_NOT_ALLOWED_FOR_LOGIN_TYPE, 3031,
        :VIX_E_LOGIN_TYPE_NOT_SUPPORTED, 3032,
        :VIX_E_EMPTY_PASSWORD_NOT_ALLOWED_IN_GUEST, 3033,
        :VIX_E_INTERACTIVE_SESSION_NOT_PRESENT, 3034,
        :VIX_E_INTERACTIVE_SESSION_USER_MISMATCH, 3035,
        # VIX_E_UNABLE_TO_REPLAY_VM, 3039, Removed in version 1.11
        :VIX_E_CANNOT_POWER_ON_VM, 3041,
        :VIX_E_NO_DISPLAY_SERVER, 3043,
        # VIX_E_VM_NOT_RECORDING, 3044, Removed in version 1.11
        # VIX_E_VM_NOT_REPLAYING, 3045, Removed in version 1.11
        :VIX_E_TOO_MANY_LOGONS, 3046,
        :VIX_E_INVALID_AUTHENTICATION_SESSION, 3047,

        # VM Errors
        :VIX_E_VM_NOT_FOUND, 4000,
        :VIX_E_NOT_SUPPORTED_FOR_VM_VERSION, 4001,
        :VIX_E_CANNOT_READ_VM_CONFIG, 4002,
        :VIX_E_TEMPLATE_VM, 4003,
        :VIX_E_VM_ALREADY_LOADED, 4004,
        :VIX_E_VM_ALREADY_UP_TO_DATE, 4006,
        :VIX_E_VM_UNSUPPORTED_GUEST, 4011,

        # Property Errors
        :VIX_E_UNRECOGNIZED_PROPERTY, 6000,
        :VIX_E_INVALID_PROPERTY_VALUE, 6001,
        :VIX_E_READ_ONLY_PROPERTY, 6002,
        :VIX_E_MISSING_REQUIRED_PROPERTY, 6003,
        :VIX_E_INVALID_SERIALIZED_DATA, 6004,
        :VIX_E_PROPERTY_TYPE_MISMATCH, 6005,

        # Completion Errors
        :VIX_E_BAD_VM_INDEX, 8000,

        # Message errors
        :VIX_E_INVALID_MESSAGE_HEADER, 10_000,
        :VIX_E_INVALID_MESSAGE_BODY, 10_001,

        # Snapshot errors
        :VIX_E_SNAPSHOT_INVAL, 13_000,
        :VIX_E_SNAPSHOT_DUMPER, 13_001,
        :VIX_E_SNAPSHOT_DISKLIB, 13_002,
        :VIX_E_SNAPSHOT_NOTFOUND, 13_003,
        :VIX_E_SNAPSHOT_EXISTS, 13_004,
        :VIX_E_SNAPSHOT_VERSION, 13_005,
        :VIX_E_SNAPSHOT_NOPERM, 13_006,
        :VIX_E_SNAPSHOT_CONFIG, 13_007,
        :VIX_E_SNAPSHOT_NOCHANGE, 13_008,
        :VIX_E_SNAPSHOT_CHECKPOINT, 13_009,
        :VIX_E_SNAPSHOT_LOCKED, 13_010,
        :VIX_E_SNAPSHOT_INCONSISTENT, 13_011,
        :VIX_E_SNAPSHOT_NAMETOOLONG, 13_012,
        :VIX_E_SNAPSHOT_VIXFILE, 13_013,
        :VIX_E_SNAPSHOT_DISKLOCKED, 13_014,
        :VIX_E_SNAPSHOT_DUPLICATEDDISK, 13_015,
        :VIX_E_SNAPSHOT_INDEPENDENTDISK, 13_016,
        :VIX_E_SNAPSHOT_NONUNIQUE_NAME, 13_017,
        :VIX_E_SNAPSHOT_MEMORY_ON_INDEPENDENT_DISK, 13_018,
        :VIX_E_SNAPSHOT_MAXSNAPSHOTS, 13_019,
        :VIX_E_SNAPSHOT_MIN_FREE_SPACE, 13_020,
        :VIX_E_SNAPSHOT_HIERARCHY_TOODEEP, 13_021,
        :VIX_E_SNAPSHOT_RRSUSPEND, 13_022,
        :VIX_E_SNAPSHOT_NOT_REVERTABLE, 13_024,

        # Host Errors
        :VIX_E_HOST_DISK_INVALID_VALUE, 14_003,
        :VIX_E_HOST_DISK_SECTORSIZE, 14_004,
        :VIX_E_HOST_FILE_ERROR_EOF, 14_005,
        :VIX_E_HOST_NETBLKDEV_HANDSHAKE, 14_006,
        :VIX_E_HOST_SOCKET_CREATION_ERROR, 14_007,
        :VIX_E_HOST_SERVER_NOT_FOUND, 14_008,
        :VIX_E_HOST_NETWORK_CONN_REFUSED, 14_009,
        :VIX_E_HOST_TCP_SOCKET_ERROR, 14_010,
        :VIX_E_HOST_TCP_CONN_LOST, 14_011,
        :VIX_E_HOST_NBD_HASHFILE_VOLUME, 14_012,
        :VIX_E_HOST_NBD_HASHFILE_INIT, 14_013,

        # Disklib errors
        :VIX_E_DISK_INVAL, 16_000,
        :VIX_E_DISK_NOINIT, 16_001,
        :VIX_E_DISK_NOIO, 16_002,
        :VIX_E_DISK_PARTIALCHAIN, 16_003,
        :VIX_E_DISK_NEEDSREPAIR, 16_006,
        :VIX_E_DISK_OUTOFRANGE, 16_007,
        :VIX_E_DISK_CID_MISMATCH, 16_008,
        :VIX_E_DISK_CANTSHRINK, 16_009,
        :VIX_E_DISK_PARTMISMATCH, 16_010,
        :VIX_E_DISK_UNSUPPORTEDDISKVERSION, 16_011,
        :VIX_E_DISK_OPENPARENT, 16_012,
        :VIX_E_DISK_NOTSUPPORTED, 16_013,
        :VIX_E_DISK_NEEDKEY, 16_014,
        :VIX_E_DISK_NOKEYOVERRIDE, 16_015,
        :VIX_E_DISK_NOTENCRYPTED, 16_016,
        :VIX_E_DISK_NOKEY, 16_017,
        :VIX_E_DISK_INVALIDPARTITIONTABLE, 16_018,
        :VIX_E_DISK_NOTNORMAL, 16_019,
        :VIX_E_DISK_NOTENCDESC, 16_020,
        :VIX_E_DISK_NEEDVMFS, 16_022,
        :VIX_E_DISK_RAWTOOBIG, 16_024,
        :VIX_E_DISK_TOOMANYOPENFILES, 16_027,
        :VIX_E_DISK_TOOMANYREDO, 16_028,
        :VIX_E_DISK_RAWTOOSMALL, 16_029,
        :VIX_E_DISK_INVALIDCHAIN, 16_030,
        :VIX_E_DISK_KEY_NOTFOUND, 16_052, # metadata key is not found
        :VIX_E_DISK_SUBSYSTEM_INIT_FAIL, 16_053,
        :VIX_E_DISK_INVALID_CONNECTION, 16_054,
        :VIX_E_DISK_ENCODING, 16_061,
        :VIX_E_DISK_CANTREPAIR, 16_062,
        :VIX_E_DISK_INVALIDDISK, 16_063,
        :VIX_E_DISK_NOLICENSE, 16_064,
        :VIX_E_DISK_NODEVICE, 16_065,
        :VIX_E_DISK_UNSUPPORTEDDEVICE, 16_066,
        :VIX_E_DISK_CAPACITY_MISMATCH, 16_067,
        :VIX_E_DISK_PARENT_NOTALLOWED, 16_068,
        :VIX_E_DISK_ATTACH_ROOTLINK, 16_069,

        # Crypto Library Errors
        :VIX_E_CRYPTO_UNKNOWN_ALGORITHM, 17_000,
        :VIX_E_CRYPTO_BAD_BUFFER_SIZE, 17_001,
        :VIX_E_CRYPTO_INVALID_OPERATION, 17_002,
        :VIX_E_CRYPTO_RANDOM_DEVICE, 17_003,
        :VIX_E_CRYPTO_NEED_PASSWORD, 17_004,
        :VIX_E_CRYPTO_BAD_PASSWORD, 17_005,
        :VIX_E_CRYPTO_NOT_IN_DICTIONARY, 17_006,
        :VIX_E_CRYPTO_NO_CRYPTO, 17_007,
        :VIX_E_CRYPTO_ERROR, 17_008,
        :VIX_E_CRYPTO_BAD_FORMAT, 17_009,
        :VIX_E_CRYPTO_LOCKED, 17_010,
        :VIX_E_CRYPTO_EMPTY, 17_011,
        :VIX_E_CRYPTO_KEYSAFE_LOCATOR, 17_012,

        # Remoting Errors.
        :VIX_E_CANNOT_CONNECT_TO_HOST, 18_000,
        :VIX_E_NOT_FOR_REMOTE_HOST, 18_001,
        :VIX_E_INVALID_HOSTNAME_SPECIFICATION, 18_002,

        # Screen Capture Errors.
        :VIX_E_SCREEN_CAPTURE_ERROR, 19_000,
        :VIX_E_SCREEN_CAPTURE_BAD_FORMAT, 19_001,
        :VIX_E_SCREEN_CAPTURE_COMPRESSION_FAIL, 19_002,
        :VIX_E_SCREEN_CAPTURE_LARGE_DATA, 19_003,

        # Guest Errors
        :VIX_E_GUEST_VOLUMES_NOT_FROZEN, 20_000,
        :VIX_E_NOT_A_FILE, 20_001,
        :VIX_E_NOT_A_DIRECTORY, 20_002,
        :VIX_E_NO_SUCH_PROCESS, 20_003,
        :VIX_E_FILE_NAME_TOO_LONG, 20_004,
        :VIX_E_OPERATION_DISABLED, 20_005,

        # Tools install errors
        :VIX_E_TOOLS_INSTALL_NO_IMAGE, 21_000,
        :VIX_E_TOOLS_INSTALL_IMAGE_INACCESIBLE, 21_001,
        :VIX_E_TOOLS_INSTALL_NO_DEVICE, 21_002,
        :VIX_E_TOOLS_INSTALL_DEVICE_NOT_CONNECTED, 21_003,
        :VIX_E_TOOLS_INSTALL_CANCELLED, 21_004,
        :VIX_E_TOOLS_INSTALL_INIT_FAILED, 21_005,
        :VIX_E_TOOLS_INSTALL_AUTO_NOT_SUPPORTED, 21_006,
        :VIX_E_TOOLS_INSTALL_GUEST_NOT_READY, 21_007,
        :VIX_E_TOOLS_INSTALL_SIG_CHECK_FAILED, 21_008,
        :VIX_E_TOOLS_INSTALL_ERROR, 21_009,
        :VIX_E_TOOLS_INSTALL_ALREADY_UP_TO_DATE, 21_010,
        :VIX_E_TOOLS_INSTALL_IN_PROGRESS, 21_011,
        :VIX_E_TOOLS_INSTALL_IMAGE_COPY_FAILED, 21_012,

        # Wrapper Errors
        :VIX_E_WRAPPER_WORKSTATION_NOT_INSTALLED, 22_001,
        :VIX_E_WRAPPER_VERSION_NOT_FOUND, 22_002,
        :VIX_E_WRAPPER_SERVICEPROVIDER_NOT_FOUND, 22_003,
        :VIX_E_WRAPPER_PLAYER_NOT_INSTALLED, 22_004,
        :VIX_E_WRAPPER_RUNTIME_NOT_INSTALLED, 22_005,
        :VIX_E_WRAPPER_MULTIPLE_SERVICEPROVIDERS, 22_006,

        # FuseMnt errors
        :VIX_E_MNTAPI_MOUNTPT_NOT_FOUND, 24_000,
        :VIX_E_MNTAPI_MOUNTPT_IN_USE, 24_001,
        :VIX_E_MNTAPI_DISK_NOT_FOUND, 24_002,
        :VIX_E_MNTAPI_DISK_NOT_MOUNTED, 24_003,
        :VIX_E_MNTAPI_DISK_IS_MOUNTED, 24_004,
        :VIX_E_MNTAPI_DISK_NOT_SAFE, 24_005,
        :VIX_E_MNTAPI_DISK_CANT_OPEN, 24_006,
        :VIX_E_MNTAPI_CANT_READ_PARTS, 24_007,
        :VIX_E_MNTAPI_UMOUNT_APP_NOT_FOUND, 24_008,
        :VIX_E_MNTAPI_UMOUNT, 24_009,
        :VIX_E_MNTAPI_NO_MOUNTABLE_PARTITONS, 24_010,
        :VIX_E_MNTAPI_PARTITION_RANGE, 24_011,
        :VIX_E_MNTAPI_PERM, 24_012,
        :VIX_E_MNTAPI_DICT, 24_013,
        :VIX_E_MNTAPI_DICT_LOCKED, 24_014,
        :VIX_E_MNTAPI_OPEN_HANDLES, 24_015,
        :VIX_E_MNTAPI_CANT_MAKE_VAR_DIR, 24_016,
        :VIX_E_MNTAPI_NO_ROOT, 24_017,
        :VIX_E_MNTAPI_LOOP_FAILED, 24_018,
        :VIX_E_MNTAPI_DAEMON, 24_019,
        :VIX_E_MNTAPI_INTERNAL, 24_020,
        :VIX_E_MNTAPI_SYSTEM, 24_021,
        :VIX_E_MNTAPI_NO_CONNECTION_DETAILS, 24_022,
        # FuseMnt errors: Do not exceed 24299

        # VixMntapi errors
        :VIX_E_MNTAPI_INCOMPATIBLE_VERSION, 24_300,
        :VIX_E_MNTAPI_OS_ERROR, 24_301,
        :VIX_E_MNTAPI_DRIVE_LETTER_IN_USE, 24_302,
        :VIX_E_MNTAPI_DRIVE_LETTER_ALREADY_ASSIGNED, 24_303,
        :VIX_E_MNTAPI_VOLUME_NOT_MOUNTED, 24_304,
        :VIX_E_MNTAPI_VOLUME_ALREADY_MOUNTED, 24_305,
        :VIX_E_MNTAPI_FORMAT_FAILURE, 24_306,
        :VIX_E_MNTAPI_NO_DRIVER, 24_307,
        :VIX_E_MNTAPI_ALREADY_OPENED, 24_308,
        :VIX_E_MNTAPI_ITEM_NOT_FOUND, 24_309,
        :VIX_E_MNTAPI_UNSUPPROTED_BOOT_LOADER, 24_310,
        :VIX_E_MNTAPI_UNSUPPROTED_OS, 24_311,
        :VIX_E_MNTAPI_CODECONVERSION, 24_312,
        :VIX_E_MNTAPI_REGWRITE_ERROR, 24_313,
        :VIX_E_MNTAPI_UNSUPPORTED_FT_VOLUME, 24_314,
        :VIX_E_MNTAPI_PARTITION_NOT_FOUND, 24_315,
        :VIX_E_MNTAPI_PUTFILE_ERROR, 24_316,
        :VIX_E_MNTAPI_GETFILE_ERROR, 24_317,
        :VIX_E_MNTAPI_REG_NOT_OPENED, 24_318,
        :VIX_E_MNTAPI_REGDELKEY_ERROR, 24_319,
        :VIX_E_MNTAPI_CREATE_PARTITIONTABLE_ERROR, 24_320,
        :VIX_E_MNTAPI_OPEN_FAILURE, 24_321,
        :VIX_E_MNTAPI_VOLUME_NOT_WRITABLE, 24_322,

        # Network Errors
        :VIX_E_NET_HTTP_UNSUPPORTED_PROTOCOL, 30_001,
        :VIX_E_NET_HTTP_URL_MALFORMAT, 30_003,
        :VIX_E_NET_HTTP_COULDNT_RESOLVE_PROXY, 30_005,
        :VIX_E_NET_HTTP_COULDNT_RESOLVE_HOST, 30_006,
        :VIX_E_NET_HTTP_COULDNT_CONNECT, 30_007,
        :VIX_E_NET_HTTP_HTTP_RETURNED_ERROR, 30_022,
        :VIX_E_NET_HTTP_OPERATION_TIMEDOUT, 30_028,
        :VIX_E_NET_HTTP_SSL_CONNECT_ERROR, 30_035,
        :VIX_E_NET_HTTP_TOO_MANY_REDIRECTS, 30_047,
        :VIX_E_NET_HTTP_TRANSFER, 30_200,
        :VIX_E_NET_HTTP_SSL_SECURITY, 30_201,
        :VIX_E_NET_HTTP_GENERIC, 30_202
      )

      # Disk types
      DiskType = enum(
        :DISK_MONOLITHIC_SPARSE, 1,  # monolithic file, sparse
        :DISK_MONOLITHIC_FLAT,   2,  # monolithic file, all space pre-allocated
        :DISK_SPLIT_SPARSE,      3,  # disk split into 2GB extents, sparse
        :DISK_SPLIT_FLAT,        4,  # disk split into 2GB extents, pre-allocated
        :DISK_VMFS_FLAT,         5,  # ESX 3.0 and above flat disks
        :DISK_STREAM_OPTIMIZED,  6,  # compressed monolithic sparse
        :DISK_VMFS_THIN,         7,  # ESX 3.0 and above thin provisioned
        :DISK_VMFS_SPARSE,       8,  # ESX 3.0 and above sparse disks
        :DISK_UNKNOWN,           256 # unknown type
      )

      # Disk adapter types
      AdapterType = enum(
        :ADAPTER_IDE,           1,
        :ADAPTER_SCSI_BUSLOGIC, 2,
        :ADAPTER_SCSI_LSILOGIC, 3,
        :ADAPTER_UNKNOWN,       256
      )

      # Credential Type - SessionId not yet supported
      CredType = enum(
        :VIXDISKLIB_CRED_UID,         1, # use userid password
        :VIXDISKLIB_CRED_SESSIONID,   2, # http session id
        :VIXDISKLIB_CRED_TICKETID,    3, # vim ticket id
        :VIXDISKLIB_CRED_SSPI,        4, # Windows only - use current thread credentials.
        :VIXDISKLIB_CRED_UNKNOWN,     256
      )
    end
  end
end
