import 'dart:convert';
import 'dart:io';

class Profile {
  final String username;
  final bool cracked;
  final String? profilePictureUrl;
  final String? wulfcoId;
  final String? microsoftId;

  Profile({required this.username, required this.cracked, this.profilePictureUrl, this.wulfcoId, this.microsoftId});

  factory Profile.fromJson(Map<String, dynamic> json) {
    if (json['cracked']) {
      return Profile(
        username: json['username'],
        cracked: json['cracked'],
        wulfcoId: json['wulfcoId'],
        profilePictureUrl: json['profilePictureUrl'],
      );
    } else {
      return Profile(
        username: json['username'],
        cracked: json['cracked'],
        microsoftId: json['microsoftId'],
        profilePictureUrl: json['profilePictureUrl'],
      );
    }
  }

  // Convert object to JSON map
  Map<String, dynamic> toJson() => {
     "username": username,
     "cracked": cracked,
     "profilePictureUrl": profilePictureUrl,
     "wulfcoId": wulfcoId,
     "microsoftId": microsoftId,
  };
}

class ProfilesData {
  final List<Profile> profiles;

  ProfilesData({required this.profiles});

  // Convert object to JSON map
  Map<String, dynamic> toJson() => {"profiles": [Profile]};

  factory ProfilesData.fromJson(Map<String, dynamic> json) {
    // loop through json and create a list of profiles
    List<Profile> profiles = [];
    for (var profile in json['profiles']) {
      profiles.add(Profile.fromJson(profile));
    }

    return ProfilesData(
      profiles: profiles,
    );
  }
}

Future<Profile> getProfile(String username) async {
  final file = File('profiles.json');
  final contents = await file.readAsString();
  final jsonMap = json.decode(contents);

  for (var profile in jsonMap['profiles']) {
    if (profile['username'] == username) {
      return Profile.fromJson(profile);
    }
  }

  return Profile(username: 'notFound', cracked: false);
}

Future<ProfilesData> getProfiles() async {
  final file = File('profiles.json');
  final contents = await file.readAsString();
  final jsonMap = json.decode(contents);

  return ProfilesData.fromJson(jsonMap);
}

Future<int> getProfilesCount() async {
  final file = File('profiles.json');
  final contents = await file.readAsString();
  final jsonMap = json.decode(contents);

  final profilesData = ProfilesData.fromJson(jsonMap);
  return profilesData.profiles.length;
}

Future<void> checkIfProfilesFileExists() async {
  final file = File('profiles.json');
  if (!await file.exists()) {
    await file.create();
    await file.writeAsString('{"profiles": []}');
  }
}

void write(Profile data, String profileName) async {
  final file = File('profiles.json');
  final contents = await file.readAsString();
  final jsonMap = json.decode(contents);

  for (var profile in jsonMap['profiles']) {
    if (profile['username'] == profileName) {
      profile['cracked'] = data.cracked;
    }
  }

  await file.writeAsString(json.encode(jsonMap));

  return;
}
