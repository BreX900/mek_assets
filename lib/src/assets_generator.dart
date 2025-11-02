import 'package:mek_assets/src/helpers/entities_finder_helper.dart';
import 'package:mek_assets/src/helpers/helper_core.dart';
import 'package:mek_assets/src/helpers/library_builder_helper.dart';
import 'package:mek_assets/src/helpers/library_writer_helper.dart';

class AssetsGenerator extends HelperCore
    with LibraryBuilderHelper, LibraryWriterHelper, EntitiesFinderHelper {
  const AssetsGenerator({required super.fileSystem, required super.pubspec, required super.config});

  Future<void> generate() async {
    final entities = await findEntities();

    final library = buildLibrary(entities);

    await writeLibrary(library);
  }
}
