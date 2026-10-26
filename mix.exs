defmodule Mix.Tasks.Compile.BinaryPhoenixCrm do
  use Mix.Task.Compiler
  @moduledoc false
  @root __DIR__
  @checksums %{
    "ebin/Elixir.PhoenixCRM.Activity.beam" =>
      "986D9DE78AEAB9CEF245B1151081C63EEBB7083B777E5386607830EF7A858656",
    "ebin/Elixir.PhoenixCRM.Address.beam" =>
      "F3635B4EBEBEB7DEE0123523FFA1BA32F17C6A1188788609ACE908771E0AB949",
    "ebin/Elixir.PhoenixCRM.AreaRules.beam" =>
      "7235A369A24D24A4C561258820935BA66A82C7FCFEE3025F8128188760E93CE4",
    "ebin/Elixir.PhoenixCRM.ContactLifecycleMigration.beam" =>
      "DCE38F16A4E0D6DD3E15A45E960266CB35FB9F4390451F54458C103A1C8D73CA",
    "ebin/Elixir.PhoenixCRM.ContactSource.beam" =>
      "F6428976D8196618194A06CAC8BE1838785768D328AC9E9FAF6272206759BA5A",
    "ebin/Elixir.PhoenixCRM.Geography.beam" =>
      "817C013D4954F31D3D4928F0923AB559B555809D0273F3499AD330D45AB25B04",
    "ebin/Elixir.PhoenixCRM.ListRules.beam" =>
      "0F481CC7C3E39A5796AC7417249A996D3EA19E22892B6AAB55143C563A7A2D89",
    "ebin/Elixir.PhoenixCRM.MailingList.beam" =>
      "C608C07F1A16581850A6261849B8F4A956DBC0FCCAF5EB7ADEB1845DA0F34D4C",
    "ebin/Elixir.PhoenixCRM.MailingListEvent.beam" =>
      "7CA4883FD2BB244077DC6FA3BBEB69B6C02BA86C64D288A46D34CDF122B9E273",
    "ebin/Elixir.PhoenixCRM.MailingLists.beam" =>
      "CCEC89DBEB991465581A1E05AA21FD9285723D2507970508ED7A85CCBCDA75F6",
    "ebin/Elixir.PhoenixCRM.MailingListsMigration.beam" =>
      "97FA3A638FCE9CEBA8B295CA97F92F71210C30F31347B216090BD6E055709454",
    "ebin/Elixir.PhoenixCRM.Merge.beam" =>
      "3E61824038EC84A72084D6FB5C22534EC0AEA40D33FBDFE4DC726220796D731B",
    "ebin/Elixir.PhoenixCRM.Migration.beam" =>
      "C120A08B3A641D432124F2B8D977F5B2B44718F95C276A5AB69000B043400A19",
    "ebin/Elixir.PhoenixCRM.Person.beam" =>
      "DE318A17407B1BDB1C3E6B9233E9100BCA8758D167457D29201C56C9D3B70271",
    "ebin/Elixir.PhoenixCRM.Policy.beam" =>
      "8909651CBF082C1512103D87973157A96C8B538AA42C2B4B4E5351B87AA83905",
    "ebin/Elixir.PhoenixCRM.Source.beam" =>
      "CB5D043A9CF4D626A235E530184A086B48A9260732A4BD25FC6472E9B81DFE57",
    "ebin/Elixir.PhoenixCRM.SourceMetadata.beam" =>
      "62E35CEDBE05750DD8FA84B1368D04A74D2C51C6723977299755E26419B6BD16",
    "ebin/Elixir.PhoenixCRM.beam" =>
      "BDBD0C1B5DC70679B372772E81311C59691614DF082F9A2CEEAF26BAF00DCF6D",
    "ebin/phoenix_crm.app" => "1A2485CF21582F3849CBD8D296752789C2B8A92B8578CCA14F97972701FEA3F4"
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
      version: "0.0.9",
      elixir: "~> 1.20.0",
      compilers: [:binary_phoenix_crm],
      deps: [ecto_sql: "~> 3.13", jason: "~> 1.4"]
    ]
  end

  def application, do: [extra_applications: [:logger]]
end
