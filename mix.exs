defmodule Mix.Tasks.Compile.BinaryPhoenixCrm do
  use Mix.Task.Compiler
  @moduledoc false
  @root __DIR__
  @checksums %{
    "ebin/Elixir.Inspect.PhoenixCRM.Conversation.beam" =>
      "BB3DCC5DCFFFCA6C7AD2351DE89CC5484F31653FE80F091F7B346AB53FDDFA76",
    "ebin/Elixir.Inspect.PhoenixCRM.Message.beam" =>
      "F8E6E2FAC4B619E18097321B877708C706DF86CD7EF2B99D0DD89CFFB0ACC222",
    "ebin/Elixir.PhoenixCRM.Activity.beam" =>
      "95AA31EFAB295D0FE9A792B9968896322996126E4C6A32D948892D05B80D8281",
    "ebin/Elixir.PhoenixCRM.Address.beam" =>
      "867A081375A851CDB6FB85AA15074BC4BD652D368E2D8815B7399303003C2E67",
    "ebin/Elixir.PhoenixCRM.AreaRules.beam" =>
      "7235A369A24D24A4C561258820935BA66A82C7FCFEE3025F8128188760E93CE4",
    "ebin/Elixir.PhoenixCRM.ContactLifecycleMigration.beam" =>
      "DCE38F16A4E0D6DD3E15A45E960266CB35FB9F4390451F54458C103A1C8D73CA",
    "ebin/Elixir.PhoenixCRM.ContactSource.beam" =>
      "F6428976D8196618194A06CAC8BE1838785768D328AC9E9FAF6272206759BA5A",
    "ebin/Elixir.PhoenixCRM.Conversation.beam" =>
      "554F8CF920869C7FBC8A7B8AE5F47DA0120CF81C42A59B590C6CD8677C51419E",
    "ebin/Elixir.PhoenixCRM.ConversationMigration.beam" =>
      "D752A723BB88E0EC197E9A21C9054721CF2C83660D70676DC68A9364734578D5",
    "ebin/Elixir.PhoenixCRM.Conversations.beam" =>
      "7101765754F16903C434B7B8063AAA28DD0797F936D6474A4CD614757599B4D9",
    "ebin/Elixir.PhoenixCRM.Geography.beam" =>
      "6539D46C76C9F6335E7102809A6577055FD4CEBA0CBC4B47FC14F4E33A614B83",
    "ebin/Elixir.PhoenixCRM.InboundReceiptSchema.beam" =>
      "CB2D50654C3B5143814CD538763BEA46BBC235B1263B7D3338B1D86697EE853F",
    "ebin/Elixir.PhoenixCRM.ListRules.beam" =>
      "0F481CC7C3E39A5796AC7417249A996D3EA19E22892B6AAB55143C563A7A2D89",
    "ebin/Elixir.PhoenixCRM.MailingList.beam" =>
      "0460F5BECB8B1C0A838AC0EAA80912553879128889E1ACACBA4853A409332D62",
    "ebin/Elixir.PhoenixCRM.MailingListEvent.beam" =>
      "D07552EB5A3794B45092BDDCFB2C8CDDE1B891320D6E337D5B4F484BA16D19D1",
    "ebin/Elixir.PhoenixCRM.MailingLists.beam" =>
      "B7EB752F44064C23A16A1EBFC9D80C412975B99E5AE3DC5C2BD5013BF8A055E0",
    "ebin/Elixir.PhoenixCRM.MailingListsMigration.beam" =>
      "97FA3A638FCE9CEBA8B295CA97F92F71210C30F31347B216090BD6E055709454",
    "ebin/Elixir.PhoenixCRM.Merge.beam" =>
      "C655BE16ABEC7C0BDCC196A51A70135ABEAEC167E821300FC912B92120B41B97",
    "ebin/Elixir.PhoenixCRM.Message.beam" =>
      "3B6BE35C6B5B7445532301550CEE06A1A5E1DF263B1FCCA0D7B1535A3B6A7901",
    "ebin/Elixir.PhoenixCRM.Migration.beam" =>
      "C120A08B3A641D432124F2B8D977F5B2B44718F95C276A5AB69000B043400A19",
    "ebin/Elixir.PhoenixCRM.Person.beam" =>
      "2F4B10E979A761A650B5B3B2379CEAB4BD5E1CE2EAE7F46116A463F1A198AFD3",
    "ebin/Elixir.PhoenixCRM.Policy.beam" =>
      "8909651CBF082C1512103D87973157A96C8B538AA42C2B4B4E5351B87AA83905",
    "ebin/Elixir.PhoenixCRM.ReceiptStore.beam" =>
      "E1B3996A145076753D9DF4DFE542572BF30F3C0EC103E41542AB6134E1589578",
    "ebin/Elixir.PhoenixCRM.ReplyNotificationSchema.beam" =>
      "43ABF890F88BC28F0109C0F7416DDBB56847FE88EE7286BD09E4EF3D97395DCF",
    "ebin/Elixir.PhoenixCRM.Source.beam" =>
      "2129DE532D4DAFB9D817482B3CC15D4925EA6902EE4BDBD39B368AB02ED4FAD7",
    "ebin/Elixir.PhoenixCRM.SourceMetadata.beam" =>
      "62E35CEDBE05750DD8FA84B1368D04A74D2C51C6723977299755E26419B6BD16",
    "ebin/Elixir.PhoenixCRM.beam" =>
      "4C5389A0720F75A09D923871066F1AF80B8595815C6E6CF1886D503FBDD569B9",
    "ebin/phoenix_crm.app" => "880594A7DB30E251D19ABE4A0BE142940CECAB6B97A07AE1943A2F4E515B64E2"
  }

  @impl true
  def run(_args) do
    series = Version.parse!(System.version()) |> Map.take([:major, :minor])

    unless series == %{major: 1, minor: 20} and System.otp_release() == "29" do
      Mix.raise("phoenix_crm requires a binary distribution for Elixir 1.20.x / OTP 29")
    end

    for {path, expected} <- @checksums do
      bytes = File.read!(Path.join(@root, path))

      unless Base.encode16(:crypto.hash(:sha256, bytes)) == expected do
        Mix.raise("phoenix_crm artifact checksum mismatch: #{path}")
      end

      if String.starts_with?(path, "ebin/") do
        target = Path.join(Mix.Project.compile_path(), Path.basename(path))
        File.mkdir_p!(Path.dirname(target))
        File.write!(target, bytes)
      end
    end

    {:ok, []}
  end
end

defmodule Compiled.PhoenixCrm.MixProject do
  use Mix.Project

  def project do
    [
      app: :phoenix_crm,
      version: "0.0.11",
      elixir: "~> 1.20.0",
      compilers: [:binary_phoenix_crm],
      deps: [ecto_sql: "~> 3.13", jason: "~> 1.4"]
    ]
  end

  def application, do: [extra_applications: [:logger]]
end
