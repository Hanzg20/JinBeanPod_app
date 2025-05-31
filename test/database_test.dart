import 'package:postgrest/postgrest.dart';
import 'package:test/test.dart';

void main() {
  late PostgrestClient client;

  setUpAll(() {
    client = PostgrestClient(
      'http://localhost:54321/rest/v1',
      headers: {
        'apikey': 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZS1kZW1vIiwicm9sZSI6ImFub24iLCJleHAiOjE5ODM4MTI5OTZ9.CRXP1A7WOeoJeXxjNni43kdQwgnWNReilDMblYTn_I0',
      },
    );
  });

  test('Test database connection', () async {
    try {
      // Test profiles table
      final profiles = await client.from('profiles').select();
      print('Profiles: $profiles');

      // Test user_settings table
      final userSettings = await client.from('user_settings').select();
      print('User Settings: $userSettings');

      // Test addresses table
      final addresses = await client.from('addresses').select();
      print('Addresses: $addresses');

      // Test provider_profiles table
      final providerProfiles = await client.from('provider_profiles').select();
      print('Provider Profiles: $providerProfiles');

      expect(true, true); // If we get here, the test passed
    } catch (e) {
      print('Error: $e');
      fail('Database connection test failed: $e');
    }
  });
} 