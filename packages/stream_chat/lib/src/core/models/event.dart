import 'package:json_annotation/json_annotation.dart';
import 'package:stream_chat/src/core/util/serializer.dart';
import 'package:stream_chat/stream_chat.dart';

part 'event.g.dart';

/// The class that contains the information about an event
@JsonSerializable()
class Event {
  /// Constructor used for json serialization
  Event({
    this.type = 'local.event',
    this.cid,
    this.connectionId,
    DateTime? createdAt,
    this.me,
    this.user,
    this.message,
    this.totalUnreadCount,
    this.unreadChannels,
    this.reaction,
    this.online,
    this.channel,
    this.member,
    this.channelId,
    this.channelType,
    this.parentId,
    this.hardDelete,
    this.extraData = const {},
    this.isLocal = true,
  }) : createdAt = createdAt?.toUtc() ?? DateTime.now().toUtc();

  /// Create a new instance from a json
  factory Event.fromJson(Map<String, dynamic> json) =>
      _$EventFromJson(Serializer.moveToExtraDataFromRoot(
        json,
        topLevelFields,
      ));

  /// The type of the event
  /// [EventType] contains some predefined constant types
  final String type;

  /// The channel cid to which the event belongs
  final String? cid;

  /// The channel id to which the event belongs
  final String? channelId;

  /// The channel type to which the event belongs
  final String? channelType;

  /// The connection id in which the event has been sent
  final String? connectionId;

  /// The date of creation of the event
  final DateTime createdAt;

  /// User object of the health check user
  final OwnUser? me;

  /// User object of the current user
  final User? user;

  /// The message sent with the event
  final Message? message;

  /// The channel sent with the event
  final EventChannel? channel;

  /// The member sent with the event
  final Member? member;

  /// The reaction sent with the event
  final Reaction? reaction;

  /// The number of unread messages for current user
  final int? totalUnreadCount;

  /// User total unread channels
  final int? unreadChannels;

  /// Online status
  final bool? online;

  /// The id of the parent message of a thread
  final String? parentId;

  /// True if the event is generated by this client
  @JsonKey(defaultValue: false)
  final bool isLocal;

  /// This is true if the message has been hard deleted
  @JsonKey(includeIfNull: false)
  final bool? hardDelete;

  /// Map of custom channel extraData
  final Map<String, Object?> extraData;

  /// Create date of the last read message (notification.mark_unread)
  @JsonKey(includeToJson: false, includeFromJson: false)
  DateTime? get lastReadAt {
    if (extraData.containsKey('last_read_at')) {
      return DateTime.parse(extraData['last_read_at']! as String);
    }

    return null;
  }

  /// The number of unread messages (notification.mark_unread)
  @JsonKey(includeToJson: false, includeFromJson: false)
  int? get unreadMessages => extraData['unread_messages'] as int?;

  /// The id of the last read message (notification.mark_read)
  @JsonKey(includeToJson: false, includeFromJson: false)
  String? get lastReadMessageId => extraData['last_read_message_id'] as String?;

  /// Known top level fields.
  /// Useful for [Serializer] methods.
  static final topLevelFields = [
    'type',
    'cid',
    'connection_id',
    'created_at',
    'me',
    'user',
    'message',
    'total_unread_count',
    'unread_channels',
    'reaction',
    'online',
    'channel',
    'member',
    'channel_id',
    'channel_type',
    'parent_id',
    'hard_delete',
    'is_local',
  ];

  /// Serialize to json
  Map<String, dynamic> toJson() => Serializer.moveFromExtraDataToRoot(
        _$EventToJson(this),
      );

  /// Creates a copy of [Event] with specified attributes overridden.
  Event copyWith({
    String? type,
    String? cid,
    String? channelId,
    String? channelType,
    String? connectionId,
    DateTime? createdAt,
    OwnUser? me,
    User? user,
    Message? message,
    EventChannel? channel,
    Member? member,
    Reaction? reaction,
    int? totalUnreadCount,
    int? unreadChannels,
    bool? online,
    String? parentId,
    bool? hardDelete,
    Map<String, Object?>? extraData,
  }) =>
      Event(
        type: type ?? this.type,
        cid: cid ?? this.cid,
        connectionId: connectionId ?? this.connectionId,
        createdAt: createdAt ?? this.createdAt,
        me: me ?? this.me,
        user: user ?? this.user,
        message: message ?? this.message,
        totalUnreadCount: totalUnreadCount ?? this.totalUnreadCount,
        unreadChannels: unreadChannels ?? this.unreadChannels,
        reaction: reaction ?? this.reaction,
        online: online ?? this.online,
        channel: channel ?? this.channel,
        member: member ?? this.member,
        channelId: channelId ?? this.channelId,
        channelType: channelType ?? this.channelType,
        parentId: parentId ?? this.parentId,
        hardDelete: hardDelete ?? this.hardDelete,
        extraData: extraData ?? this.extraData,
        isLocal: isLocal,
      );
}

/// The channel embedded in the event object
@JsonSerializable(
  createToJson: false,
)
class EventChannel extends ChannelModel {
  /// Constructor used for json serialization
  EventChannel({
    this.members,
    super.id,
    super.type,
    required String super.cid,
    super.ownCapabilities,
    required ChannelConfig super.config,
    super.createdBy,
    super.frozen,
    super.lastMessageAt,
    required DateTime super.createdAt,
    required DateTime super.updatedAt,
    super.deletedAt,
    super.memberCount,
    Map<String, Object?>? extraData,
    super.cooldown,
    super.team,
    super.disabled,
    super.hidden,
    super.truncatedAt,
  }) : super(extraData: extraData ?? {});

  /// Create a new instance from a json
  factory EventChannel.fromJson(Map<String, dynamic> json) =>
      _$EventChannelFromJson(Serializer.moveToExtraDataFromRoot(
        json,
        topLevelFields,
      ));

  /// A paginated list of channel members
  final List<Member>? members;

  /// Known top level fields.
  /// Useful for [Serializer] methods.
  static final topLevelFields = [
    'members',
    ...ChannelModel.topLevelFields,
  ];
}
